import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelarin_hackjam/services/gemini_services.dart';
import 'package:kelarin_hackjam/ui/capture_ai/models/capture_ai_state.dart';
import 'package:kelarin_hackjam/ui/capture_ai/models/task_result.dart';

// Provider untuk GeminiService
final geminiServiceProvider = Provider<GeminiService>((ref) {
  return GeminiService();
});

// Provider utama untuk ViewModel
final captureAIViewModelProvider =
    StateNotifierProvider.autoDispose<CaptureAIViewModel, CaptureAIState>(
        (ref) {
  final geminiService = ref.watch(geminiServiceProvider);
  return CaptureAIViewModel(geminiService);
});

class CaptureAIViewModel extends StateNotifier<CaptureAIState> {
  final GeminiService _geminiService;
  final TextEditingController promptController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  CaptureAIViewModel(this._geminiService) : super(const CaptureAIState());

  /// 1. Mengambil Gambar dari Galeri / Kamera
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80, // Kompresi sedikit agar pengiriman cepat
      );

      if (pickedFile != null) {
        state = state.copyWith(
          selectedImage: File(pickedFile.path),
          clearError: true,
        );
      }
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'Gagal mengambil gambar: ${e.toString()}',
      );
    }
  }

  /// 2. Hapus gambar yang terpilih
  void removeImage() {
    state = state.copyWith(clearImage: true);
  }

  /// 3. Proses ekstraksi data ke Gemini AI
  Future<bool> processTaskWithAI() async {
    final promptText = promptController.text.trim();

    // Validasi input: Harus ada teks atau gambar
    if (promptText.isEmpty && state.selectedImage == null) {
      state = state.copyWith(
        errorMessage:
            'Ketik perintah/tugas atau masukkan foto terlebih dahulu.',
      );
      return false;
    }

    // Set status loading
    state = state.copyWith(
      isLoading: true,
      clearError: true,
      clearTaskResult: true,
    );

    try {
      final result = await _geminiService.extractTask(
        textPrompt: promptText.isNotEmpty ? promptText : null,
        imageFile: state.selectedImage,
      );

      if (result != null) {
        state = state.copyWith(
          isLoading: false,
          taskResult: result,
        );
        return true; // Berhasil
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Gagal mengekstrak tugas. Coba lagi.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Terjadi kesalahan: ${e.toString()}',
      );
      return false;
    }
  }

  /// 4. Memungkinkan pengguna mengedit hasil ekstraksi sebelum disimpan
  void updateTaskResult(AITaskResult updatedResult) {
    state = state.copyWith(taskResult: updatedResult);
  }

  /// 5. Reset semua form & state
  void resetForm() {
    promptController.clear();
    state = const CaptureAIState();
  }

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }
}
