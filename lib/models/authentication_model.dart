class AuthenticationBlocState {
  AuthenticationBlocState({
    required this.message,
    required this.isLogin,
    this.userName,
    this.email,
  }) : super();

  final String message;
  final bool isLogin;
  final String? userName;
  final String? email;
}
