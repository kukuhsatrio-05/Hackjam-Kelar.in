import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kelarin_hackjam/ui/capture_ai/views/input_tugas_baru.dart';

void main() async {
  // 1. Pastikan Flutter Binding sudah siap
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Load file .env untuk API Key Gemini
  await dotenv.load(fileName: "assets/env");
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelarin Hackjam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      // 4. Panggil halaman InputTugasBaruView di sini sebagai home
      home: const InputTugasBaruView(),
    );
  }
}
