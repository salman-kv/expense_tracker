import 'package:expense_tracker/core/common/shared_prefrences/shared_prefrence.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/features/auth/domain/usecases/current_user.dart';
import 'package:expense_tracker/features/auth/domain/usecases/user_login.dart';
import 'package:expense_tracker/features/auth/domain/usecases/user_sign_up.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_event.dart';
import 'package:expense_tracker/features/auth/presentation/bloc/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthUserSignUpEvent>(_authUserSignUp);
    on<AuthUserLoginEvent>(_authUserLogin);
    on<AuthCurrentUserEvent>(_authCurrentUser);
  }

  void _authCurrentUser(
      AuthCurrentUserEvent event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailureState(message: l.message)), (r) {
      _successState(user: r, emit: emit);
    });
  }

  void _authUserLogin(AuthUserLoginEvent event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
        UserLoginParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailureState(message: l.message)),
        (r) => _successState(user: r.email, emit: emit));
  }

  void _authUserSignUp(
      AuthUserSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
        UserSignUpParams(email: event.email, password: event.password));
    res.fold((l) => emit(AuthFailureState(message: l.message)),
        (r) => _successState(user: r.email, emit: emit));
  }

  void _successState({required String user, required Emitter<AuthState> emit}) {
    SharedPreferencesClass.setUserEmail(user);
    emit(AuthSuccessState(user: user));
  }
}
