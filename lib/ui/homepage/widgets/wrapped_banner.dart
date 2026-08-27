import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class BerandaWrappedBanner extends StatelessWidget {
  final VoidCallback? onTap;

  const BerandaWrappedBanner({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEBF3FC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WORK WRAPPED',
                    style: AppTextStyle.headingBold.copyWith(
                      fontSize: 18,
                      color: AppColors.darkActive,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rekap pencapaianmu seminggu ini! →',
                    style: AppTextStyle.bodyRegular.copyWith(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.darker,
            ),
          ],
        ),
      ),
    );
  }
}
