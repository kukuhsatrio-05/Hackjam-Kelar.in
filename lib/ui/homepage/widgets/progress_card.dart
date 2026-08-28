import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class BerandaProgressCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final int clientMeetings;

  const BerandaProgressCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.clientMeetings,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Main Stat Box
        Container(
          margin: const EdgeInsets.only(top: 24),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.lightHover,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress Minggu Ini',
                style: AppTextStyle.headingBold.copyWith(
                  fontSize: 16,
                  color: AppColors.darkActive,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '$completedTasks / $totalTasks',
                          style:
                              AppTextStyle.headingBold.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tugas Selesai',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${clientMeetings}x',
                          style:
                              AppTextStyle.headingBold.copyWith(fontSize: 24),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ketemu Klien',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 13,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Maskot Icon
        Positioned(
          top: -40, // Naik ekstrim untuk menimpa bubble chat
          right: 12,
          child: Image.asset(
            'assets/icons/mascot_icon.png',
            width: 110,
            height: 110,
          ),
        ),
      ],
    );
  }
}
