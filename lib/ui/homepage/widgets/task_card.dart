import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class BerandaTaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String dueDate;
  final String? priorityLabel; // e.g., 'Prioritas tinggi', 'Prioritas sedang'
  final Color? priorityColor;
  final String? clientName;
  final String? clientAvatarUrl;
  final VoidCallback? onTap;

  const BerandaTaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.dueDate,
    this.priorityLabel,
    this.priorityColor,
    this.clientName,
    this.clientAvatarUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.lightHover, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (priorityLabel != null) ...[
              Text(
                priorityLabel!,
                style: AppTextStyle.bodyBold.copyWith(
                  fontSize: 13,
                  color: priorityColor ?? const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(height: 12),
            ],
            Row(
              children: [
                if (clientAvatarUrl != null)
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(clientAvatarUrl!),
                  )
                else
                  const Icon(Icons.copy, color: AppColors.darker),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.bodyBold.copyWith(fontSize: 16),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.darker,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding:
                  EdgeInsets.only(left: clientAvatarUrl != null ? 40.0 : 36.0),
              child: Text(
                description,
                style: AppTextStyle.bodyRegular.copyWith(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.lightActive,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        category,
                        style: AppTextStyle.bodyMedium.copyWith(fontSize: 12),
                      ),
                    ),
                    if (clientName != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.lightActive,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person_outline,
                                size: 14, color: AppColors.darker),
                            const SizedBox(width: 4),
                            Text(
                              clientName!,
                              style: AppTextStyle.bodyMedium
                                  .copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                Text(
                  dueDate,
                  style: AppTextStyle.bodyRegular.copyWith(fontSize: 11),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
