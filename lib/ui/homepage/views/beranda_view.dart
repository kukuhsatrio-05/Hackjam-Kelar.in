import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';
import 'package:kelarin_hackjam/ui/homepage/viewmodel/beranda_vm.dart';
import 'package:kelarin_hackjam/ui/homepage/widgets/beranda_header.dart';
import 'package:kelarin_hackjam/ui/homepage/widgets/progress_card.dart';
import 'package:kelarin_hackjam/ui/homepage/widgets/task_card.dart';
import 'package:kelarin_hackjam/ui/homepage/widgets/wrapped_banner.dart';

class BerandaView extends ConsumerWidget {
  const BerandaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final berandaState = ref.watch(berandaViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const BerandaHeader(),
              const SizedBox(height: 24),

              // BUBBLE CHAT
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.lightActive),
                  ),
                  child: Text(
                    'Haii, siap untuk mulai hari ini?',
                    style: AppTextStyle.bodySemiBold.copyWith(
                      fontSize: 13,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 4),

              // Progress Widget
              BerandaProgressCard(
                completedTasks: berandaState.completedTasks,
                totalTasks: berandaState.totalTasks,
                clientMeetings: berandaState.clientMeetings,
              ),
              const SizedBox(height: 20),

              // Banner Work Wrapped
              const BerandaWrappedBanner(),
              const SizedBox(height: 24),

              // Daftar Tugas Header
              Text(
                'Daftar Tugas',
                style: AppTextStyle.headingBold.copyWith(
                  fontSize: 20,
                  color: AppColors.darkActive,
                ),
              ),
              const SizedBox(height: 16),

              // List Card Items
              BerandaTaskCard(
                priorityLabel: 'Prioritas tinggi',
                priorityColor: const Color(0xFFEF4444),
                title: 'Laporan Keuangan',
                description: 'Lorem ipsum dolor sit amet',
                category: 'Laporan',
                dueDate: 'Due today, 19.00',
              ),
              BerandaTaskCard(
                priorityLabel: 'Prioritas sedang',
                priorityColor: const Color(0xFFB45309),
                title: 'Buat PRD',
                description: 'Lorem ipsum dolor sit amet',
                category: '#Laporan',
                dueDate: 'Due today, 19.00',
              ),
              BerandaTaskCard(
                title: 'Ketemu Client: Bu Diny',
                description: 'Membahas kontrak kerja',
                category: '#Meeting',
                clientName: 'Bu Diny',
                clientAvatarUrl: 'https://i.pravatar.cc/150?img=5',
                dueDate: 'Due today, 19.00',
              ),
              BerandaTaskCard(
                title: 'Membuat Pitch Deck',
                description: 'Lorem ipsum dolor sit amet',
                category: '#Presentasi',
                dueDate: 'Due 25 Aug, 19.00',
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
