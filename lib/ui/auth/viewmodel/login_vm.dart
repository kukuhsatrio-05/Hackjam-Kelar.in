import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kelarin_hackjam/ui/auth/models/auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>((ref) {
  return LoginViewModel();
});

Future<void>? _googleSignInInitFuture;

Future<void> _ensureGoogleSignInInitialized() {
  return _googleSignInInitFuture ??= () async {
    final webClientId = dotenv.env['WEB_CLIENT_ID'] ?? '';

    if (webClientId.isEmpty) {
      throw Exception('WEB_CLIENT_ID tidak ditemukan di .env.');
    }

    await GoogleSignIn.instance.initialize(
      clientId: kIsWeb ? webClientId : null,
      serverClientId: kIsWeb ? null : webClientId,
    );
  }();
}

class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(const LoginState());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordObscured: !state.isPasswordObscured);
  }

  Future<bool> signInWithGoogle() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      await _ensureGoogleSignInInitialized();

      final GoogleSignInAccount googleUser =
          await GoogleSignIn.instance.authenticate();

      final idToken = googleUser.authentication.idToken;

      if (idToken == null) {
        throw Exception('ID Token tidak ditemukan.');
      }

      const scopes = ['email', 'profile'];
      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
              await googleUser.authorizationClient.authorizeScopes(scopes);

      final response = await Supabase.instance.client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );

      state = state.copyWith(isLoading: false);
      return response.user != null;
    } on GoogleSignInException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.code == GoogleSignInExceptionCode.canceled
            ? null
            : 'Gagal login Google: ${e.description ?? e.code}',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Gagal login Google: ${e.toString()}',
      );
      return false;
    }
  }

  Future<bool> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      state = state.copyWith(
        errorMessage: 'Email dan password tidak boleh kosong',
      );
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      state = state.copyWith(isLoading: false);
      return response.user != null;
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.message,
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Terjadi kesalahan tidak terduga: ${e.toString()}',
      );
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
