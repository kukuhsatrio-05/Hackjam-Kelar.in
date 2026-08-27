import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  static const String fontFamilyHeading = 'BricolageGrotesque';
  static const String fontFamilyBody = 'NunitoSans';

  // font heading
  static const TextStyle headingRegular = TextStyle(
    fontFamily: fontFamilyHeading,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: fontFamilyHeading,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingSemiBold = TextStyle(
    fontFamily: fontFamilyHeading,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle headingBold = TextStyle(
    fontFamily: fontFamilyHeading,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // font body
  static const TextStyle bodyRegular = TextStyle(
    fontFamily: fontFamilyBody,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamilyBody,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodySemiBold = TextStyle(
    fontFamily: fontFamilyBody,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyBold = TextStyle(
    fontFamily: fontFamilyBody,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );
}
