import 'dart:convert';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kelarin_hackjam/ui/capture_ai/models/task_result.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService({String? apiKey})
      : _model = GenerativeModel(
          model: 'gemini-1.5-flash',
          apiKey: apiKey ?? dotenv.env['GEMINI_API_KEY'] ?? '',
          generationConfig: GenerationConfig(
            responseMimeType: 'application/json',
          ),
        );

  Future<AITaskResult?> extractTask(
      {String? textPrompt, File? imageFile}) async {
    final systemPrompt = '''
      Kamu adalah asisten pengolah tugas. Ekstrak teks/gambar menjadi data JSON dengan kunci:
      "title", "deadline", "summary", "stakeholder", "priority".
      Jika pengguna menyebut tanggal relatif seperti "besok" atau "lusa", hitung dari tanggal hari ini (27 Agustus 2026).
      Input Teks: "${textPrompt ?? ''}"
    ''';

    final List<Part> parts = [TextPart(systemPrompt)];

    if (imageFile != null) {
      final bytes = await imageFile.readAsBytes();
      parts.add(DataPart('image/jpeg', bytes));
    }

    final response = await _model.generateContent([Content.multi(parts)]);

    if (response.text != null) {
      final jsonMap = jsonDecode(response.text!);
      return AITaskResult.fromJson(jsonMap);
    }
    return null;
  }
}
