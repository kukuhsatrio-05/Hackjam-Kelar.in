import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'core/router/app_router.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kelarin_hackjam/ui/homepage/views/beranda_view.dart';
import 'package:kelarin_hackjam/ui/auth/views/login_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kelarin_hackjam/ui/capture_ai/views/capture_selection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: "api_related.env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
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
      home: const CaptureSelectionView(),
    );
  }
}
