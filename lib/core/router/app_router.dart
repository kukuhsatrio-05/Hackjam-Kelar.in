import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kelarin_hackjam/ui/tugas/views/tugas_view.dart';
import 'package:kelarin_hackjam/ui/homepage/views/beranda_view.dart';
import 'package:kelarin_hackjam/ui/capture_ai/views/capture_selection.dart';
import 'package:kelarin_hackjam/ui/capture_ai/views/input_tugas_baru.dart';

class AppRouter {
  AppRouter._();

  static const String tugas = '/tugas';
  static const String beranda = '/beranda';
  static const String captureAi = '/capture-selection';
  static const String inputTugas = '/input-tugas-baru';

  static final GoRouter router = GoRouter(
    initialLocation: captureAi,
    routes: [
      GoRoute(
        path: beranda,
        name: 'beranda',
        builder: (BuildContext context, GoRouterState state) {
          return const BerandaView();
        },
      ),
      GoRoute(
        path: tugas,
        name: 'tugas',
        builder: (BuildContext context, GoRouterState state) {
          return const TugasView();
        },
      ),
      GoRoute(
        path: captureAi,
        name: 'captureAi',
        builder: (context, state) => const CaptureSelectionView(),
      ),
      GoRoute(
        path: inputTugas,
        name: 'inputTugas',
        builder: (context, state) => const InputTugasBaruView(),
      ),
    ],
  );
}
