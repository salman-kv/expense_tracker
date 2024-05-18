abstract class AuthEvent {}

class AuthUserSignUpEvent extends AuthEvent {
  final String email;
  final String password;

  AuthUserSignUpEvent({required this.email, required this.password});
}

class AuthUserLoginEvent extends AuthEvent {
  final String email;
  final String password;

  AuthUserLoginEvent({required this.email, required this.password});
}

class AuthCurrentUserEvent extends AuthEvent {}
