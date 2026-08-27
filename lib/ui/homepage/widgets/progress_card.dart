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
            color: const Color(0xFFEBF3FC),
            borderRadius: BorderRadius.circular(20),
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
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '$completedTasks / $totalTasks',
                          style:
                              AppTextStyle.headingBold.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tugas Selesai',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.lightHover,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          '${clientMeetings}x',
                          style:
                              AppTextStyle.headingBold.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ketemu Klien',
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
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

        Positioned(
          top: -15,
          right: 12,
          child: Image.asset(
            'assets/icons/mascot_icon.png',
            width: 80,
            height: 80,
          ),
        ),
      ],
    );
  }
}
