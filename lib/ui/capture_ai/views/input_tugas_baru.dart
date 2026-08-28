import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';
import 'package:kelarin_hackjam/ui/capture_ai/models/task_result.dart';
import 'package:kelarin_hackjam/ui/capture_ai/services/gemini_services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

class InputTugasBaruView extends ConsumerStatefulWidget {
  const InputTugasBaruView({super.key});

  @override
  ConsumerState<InputTugasBaruView> createState() => _InputTugasBaruViewState();
}

class _InputTugasBaruViewState extends ConsumerState<InputTugasBaruView> {
  final TextEditingController _textController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  bool _isThinking = false;
  bool _isSuccess = false;
  String? _userMessage;
  AITaskResult? _aiResult;

  Future<void> _processInput({File? imageFile}) async {
    if (_textController.text.isEmpty && imageFile == null) return;

    setState(() {
      _userMessage = _textController.text;
      _isThinking = true;
      _aiResult = null;
    });

    _textController.clear();

    final geminiService = GeminiService();
    final result = await geminiService.extractTask(
      textPrompt: _userMessage,
      imageFile: imageFile,
    );

    setState(() {
      _isThinking = false;
      _aiResult = result;
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _processInput(imageFile: File(image.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Input Tugas Baru',
          style: AppTextStyle.headingBold.copyWith(
            fontSize: 18,
            color: AppColors.darkActive,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat Area
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  if (_userMessage == null && !_isThinking && _aiResult == null)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(
                          'Tambah tugas baru dengan fitur\nchat atau upload dokumen melalui\nfoto!',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.bodyRegular.copyWith(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                  // User Bubble Chat
                  if (_userMessage != null && _userMessage!.isNotEmpty)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBF3FC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _userMessage!,
                          style:
                              AppTextStyle.bodyRegular.copyWith(fontSize: 13),
                        ),
                      ),
                    ),

                  // State 1: Thinking State
                  if (_isThinking)
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundColor: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Bentar yah aku mikir dulu...',
                          style: AppTextStyle.bodyRegular.copyWith(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),

                  // State 2: Result & Confirmation Card
                  if (_aiResult != null && !_isSuccess) ...[
                    Text(
                      'Oke! Silahkan konfirmasi data ini ya sebelum saya tambahkan ke daftar tugas!\n\nJika sudah benar, silahkan tekan tombol konfirmasi, namun jika ada perubahan, silahkan beritahu saya atau edit!',
                      style: AppTextStyle.bodyRegular.copyWith(fontSize: 13),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.lightHover),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Judul: ${_aiResult!.title}',
                              style: AppTextStyle.bodyMedium),
                          Text('Deadline: ${_aiResult!.deadline}',
                              style: AppTextStyle.bodyMedium),
                          Text('Summary: ${_aiResult!.summary}',
                              style: AppTextStyle.bodyMedium),
                          Text('Stakeholder: ${_aiResult!.stakeholder}',
                              style: AppTextStyle.bodyMedium),
                          Text('Priority: ${_aiResult!.priority}',
                              style: AppTextStyle.bodyMedium),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        OutlinedButton(
                          onPressed: () {},
                          child: const Text('Edit'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() => _isSuccess = true);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.dark),
                          child: const Text('Konfirmasi Benar'),
                        ),
                      ],
                    ),
                  ],

                  // State 3: Success Toast Bubble
                  if (_isSuccess)
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCFCE7),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Tugas berhasil ditambah!',
                          style: AppTextStyle.bodyBold.copyWith(
                            color: const Color(0xFF15803D),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Bottom Input Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surface,
              child: Row(
                children: [
                  // Tombol Upload Foto
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: AppColors.dark,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.upload,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Text Field Input
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Masukkan tugas/klien kamu',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide:
                              const BorderSide(color: AppColors.lightHover),
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send_rounded,
                              color: AppColors.dark),
                          onPressed: () => _processInput(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
