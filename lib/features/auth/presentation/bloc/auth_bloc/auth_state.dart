abstract class AuthState {}

final class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {
  final String user;

  AuthSuccessState({required this.user});
}

class AuthFailureState extends AuthState {
  final String message;

  AuthFailureState({required this.message});
}
