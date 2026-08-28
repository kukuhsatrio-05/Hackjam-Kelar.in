import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class TugasDetailBottomSheet extends StatelessWidget {
  final String title;
  final String description;
  final String dueDate;
  final String? priorityLabel;
  final Color? priorityColor;
  final String? clientAvatarUrl;

  const TugasDetailBottomSheet({
    super.key,
    required this.title,
    required this.description,
    required this.dueDate,
    this.priorityLabel,
    this.priorityColor,
    this.clientAvatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFFE2E8F0),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Priority Label
          if (priorityLabel != null) ...[
            Text(
              priorityLabel!,
              style: AppTextStyle.bodySemiBold.copyWith(
                color: priorityColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
          ],

          // Due Date
          Text(
            dueDate,
            style: AppTextStyle.bodyRegular.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),

          // Title & 3-Dot Menu
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.headingBold.copyWith(fontSize: 20),
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: AppColors.textPrimary),
                onSelected: (value) {
                  if (value == 'delete') {
                    // Tambahkan logika Riverpod/ViewModel untuk menghapus tugas di sini
                    Navigator.pop(context);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Icons.delete_outline,
                            color: Colors.red, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          'Hapus Tugas',
                          style: AppTextStyle.bodyMedium
                              .copyWith(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Client Section
          if (clientAvatarUrl != null) ...[
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(clientAvatarUrl!),
                ),
                const SizedBox(width: 8),
                Text(
                  'Pelajari klien →',
                  style: AppTextStyle.bodyMedium.copyWith(
                    decoration: TextDecoration.underline,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],

          // Description
          Text(
            'Lorem ipsum dolor sit amet consectetur. Massa est diam dolor mauris. At diam amet pulvinar nascetur amet at adipiscing aliquam. Felis libero gravida felis morbi. Lobortis duis lectus lacus velit.',
            style: AppTextStyle.bodyRegular.copyWith(
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),

          // Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkActive,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                'Tandai selesai',
                style: AppTextStyle.bodySemiBold.copyWith(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
