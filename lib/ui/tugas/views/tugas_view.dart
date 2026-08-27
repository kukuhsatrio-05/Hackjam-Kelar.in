import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';
import 'package:kelarin_hackjam/ui/tugas/widgets/tugas_search_field.dart';
import 'package:kelarin_hackjam/ui/tugas/widgets/tugas_filter_chip.dart';
import 'package:kelarin_hackjam/ui/tugas/widgets/tugas_card.dart';

class TugasView extends StatelessWidget {
  const TugasView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Galeri Pencapaianmu',
                style: AppTextStyle.headingBold.copyWith(
                  fontSize: 22,
                  color: AppColors.darkActive,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Lihat semua hal hebat yang berhasil kamu beresin!',
                style: AppTextStyle.bodyRegular.copyWith(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),

              const TugasSearchField(),
              const SizedBox(height: 12),
              const TugasFilterChip(),
              const SizedBox(height: 20),

              Expanded(
                child: ListView(
                  children: const [
                    TugasCardTile(
                      title: 'Buat PRD',
                      description: 'Lorem ipsum dolor sit amet',
                      category: 'Laporan',
                      completedAt: 'Selesai 22 Aug 2026, 17.00',
                    ),
                    TugasCardTile(
                      title: 'Ketemu Client: Bu Diny',
                      description: 'Lorem ipsum dolor sit amet',
                      category: 'Meeting',
                      completedAt: 'Selesai 22 Aug 2026, 17.00',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
