import 'package:flutter/material.dart';
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';

class TugasSearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const TugasSearchField({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: AppTextStyle.bodyRegular.copyWith(fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Cari memori tugas lama...',
        hintStyle: AppTextStyle.bodyRegular.copyWith(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        suffixIcon: const Icon(Icons.search, color: AppColors.darker),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.surface,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.normal, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.dark, width: 2),
        ),
      ),
    );
  }
}
