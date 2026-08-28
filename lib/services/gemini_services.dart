import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kelarin_hackjam/ui/capture_ai/models/task_result.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService({String? apiKey})
      : _model = GenerativeModel(
          // 1. Gunakan gemini-1.5-flash untuk kecepatan ekstraksi JSON (kecepatan tinggi)
          model: 'gemini-2.0-flash',
          apiKey: apiKey ?? dotenv.env['GEMINI_API_KEY'] ?? '',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
          // 2. Gunakan systemInstruction resmi SDK
          systemInstruction: Content.system('''
            Kamu adalah asisten pengolah tugas yang presisi dan cepat.
            Ekstrak teks/gambar menjadi data JSON valid dengan struktur kunci berikut:
            - "title": (String) Judul tugas singkat
            - "deadline": (String) Format YYYY-MM-DD HH:mm jika ada
            - "summary": (String) Ringkasan deskripsi tugas
            - "stakeholder": (String) Pihak terkait / penugasi
            - "priority": (String) "High", "Medium", atau "Low"

            Jika pengguna menyebut tanggal relatif seperti "besok" atau "lusa", hitung dari tanggal hari ini.
          '''),
        );

  Future<AITaskResult?> extractTask({
    String? textPrompt,
    File? imageFile,
  }) async {
    try {
      final now = DateTime.now();
      final todayStr =
          "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

      final userPromptText = '''
        Hari ini adalah tanggal: $todayStr
        Input Teks Pengguna: "${textPrompt ?? ''}"
      ''';

      final List<Part> parts = [TextPart(userPromptText)];

      // Jika ada gambar, deteksi mime-type
      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        final path = imageFile.path.toLowerCase();
        String mimeType = 'image/jpeg';
        if (path.endsWith('.png')) {
          mimeType = 'image/png';
        } else if (path.endsWith('.webp')) {
          mimeType = 'image/webp';
        }

        parts.add(DataPart(mimeType, bytes));
      }

      // 3. Batasi waktu tunggu maksimal 15 detik agar UI tidak hang selamanya
      final response = await _model.generateContent(
          [Content.multi(parts)]).timeout(const Duration(seconds: 15));

      if (response.text != null && response.text!.isNotEmpty) {
        final jsonMap = jsonDecode(response.text!);
        return AITaskResult.fromJson(jsonMap);
      }
    } catch (e) {
      // Menampilkan log error yang jelas jika gagal
      print('Error pada GeminiService: $e');
      rethrow; // Lempar error ke ViewModel agar bisa ditampilkan SnackBar di UI
    }
    return null;
  }
}
