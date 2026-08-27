import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class BerandaHeader extends StatelessWidget {
  const BerandaHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'kelar.in',
          style: AppTextStyle.headingBold.copyWith(
            fontSize: 24,
            color: AppColors.darkActive,
          ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundColor: AppColors.lightActive,
          child: Icon(Icons.person, color: AppColors.darker),
        ),
      ],
    );
  }
}
