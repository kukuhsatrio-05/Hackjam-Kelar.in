class LoginState {
  final bool isLoading;
  final bool isPasswordObscured;
  final String? errorMessage;

  const LoginState({
    this.isLoading = false,
    this.isPasswordObscured = true,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isPasswordObscured,
    String? errorMessage,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
