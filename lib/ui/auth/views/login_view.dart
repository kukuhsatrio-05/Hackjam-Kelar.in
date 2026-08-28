import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import untuk file SVG
import 'package:kelarin_hackjam/core/constants/app_colors.dart';
import 'package:kelarin_hackjam/core/constants/app_textstyle.dart';
import 'package:kelarin_hackjam/ui/auth/models/auth_state.dart';
import 'package:kelarin_hackjam/ui/auth/viewmodel/login_vm.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginViewModelProvider);
    final viewModel = ref.read(loginViewModelProvider.notifier);

    // Listener untuk menampilkan error SnackBar
    ref.listen<LoginState>(loginViewModelProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.errorMessage!),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 36),

                      // Mascot Icon
                      Image.asset(
                        'assets/icons/mascot_icon.png',
                        width: 90,
                        height: 90,
                      ),
                      const SizedBox(height: 16),

                      // Title & Subtitle
                      Text(
                        'Log In',
                        style: AppTextStyle.headingBold.copyWith(
                          fontSize: 28,
                          color: AppColors.darkActive,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Masuk dengan akun kelar.in',
                        style: AppTextStyle.bodyRegular.copyWith(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 36),

                      // Field Email
                      _buildTextField(
                        label: 'Email',
                        hintText: 'Masukkan email',
                        controller: viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 16),

                      // Field Password
                      _buildTextField(
                        label: 'Password',
                        hintText: 'Masukkan password',
                        controller: viewModel.passwordController,
                        isObscured: loginState.isPasswordObscured,
                        suffixIcon: IconButton(
                          icon: Icon(
                            loginState.isPasswordObscured
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          onPressed: viewModel.togglePasswordVisibility,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lupa Password
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            // TODO: Navigasi/Action Lupa Password
                          },
                          child: Text(
                            'Lupa Password?',
                            style: AppTextStyle.bodySemiBold.copyWith(
                              fontSize: 13,
                              color: AppColors.textPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // 1. Tombol Log In Utama
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: loginState.isLoading
                              ? null
                              : () async {
                                  final isSuccess = await viewModel.login();
                                  if (isSuccess && context.mounted) {
                                    // TODO: Navigasi ke Beranda / HomeView
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkActive,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: loginState.isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : Text(
                                  'Log In',
                                  style: AppTextStyle.bodyBold.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 2. Tombol Masuk dengan Google (Diperbaiki)
                      SizedBox(
                        width: double.infinity, // Dibuat Full Width
                        child: OutlinedButton(
                          onPressed: loginState.isLoading
                              ? null
                              : () async {
                                  final isSuccess =
                                      await viewModel.signInWithGoogle();
                                  if (isSuccess && context.mounted) {
                                    // TODO: Navigasi ke Beranda / HomeView
                                  }
                                },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            side: const BorderSide(
                              color: AppColors.lightActive,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Penggunaan SvgPicture untuk file .svg
                              SvgPicture.asset(
                                'assets/icons/google_icon.svg',
                                height: 20,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Masuk dengan Google',
                                style: AppTextStyle.bodyBold.copyWith(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Navigasi ke Register
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Tidak memiliki akun? ',
                      style: AppTextStyle.bodyRegular.copyWith(
                        fontSize: 13,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigasi ke RegisterView
                      },
                      child: Text(
                        'Register',
                        style: AppTextStyle.bodyBold.copyWith(
                          fontSize: 13,
                          color: AppColors.textPrimary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
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

  Widget _buildTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    bool isObscured = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium.copyWith(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscured,
          keyboardType: keyboardType,
          style: AppTextStyle.bodyRegular.copyWith(fontSize: 14),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyle.bodyRegular.copyWith(
              color: const Color(0xFF94A3B8),
              fontSize: 14,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: AppColors.lightActive),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide:
                  const BorderSide(color: AppColors.darkActive, width: 1.5),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
