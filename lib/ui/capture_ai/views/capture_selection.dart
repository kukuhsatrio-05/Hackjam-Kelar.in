import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class CaptureSelectionView extends StatelessWidget {
  const CaptureSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.darker),
          onPressed: () => context.pop(),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Capture & AI Summary',
              style: AppTextStyle.headingBold.copyWith(
                fontSize: 18,
                color: AppColors.darkActive,
              ),
            ),
            Text(
              'Catat tugas & klien yang kamu dapatkan!',
              style: AppTextStyle.bodyRegular.copyWith(
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Maskot Blob
              SvgPicture.asset(
                'assets/icons/mascot_kelarin.svg',
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 24),
              Text(
                'Hi! Mau catat apa hari ini?',
                style: AppTextStyle.headingBold.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 32),

              // Baris Tombol Menu (Tugas Baru & Tugas Lama)
              Row(
                children: [
                  Expanded(
                    child: _buildMenuCard(
                      context,
                      icon: Icons.assignment_outlined,
                      label: 'Tugas Baru',
                      onTap: () => context.push('/input-tugas-baru'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildMenuCard(
                      context,
                      icon: Icons.check_circle_outline,
                      label: 'Tugas Lama',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Tombol Klien Full Width
              SizedBox(
                width: double.infinity,
                child: _buildMenuCard(
                  context,
                  icon: Icons.people_outline,
                  label: 'Klien',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF3FC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Icon(icon, size: 28, color: AppColors.dark),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyle.bodyBold.copyWith(
                fontSize: 15,
                color: AppColors.darkActive,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
