import 'dart:developer';

import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/usecase/usecase.dart';
import 'package:expense_tracker/core/common/entities/user_entity.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    log('user sign up use case ');
    return await authRepository.signupWithEmailPassword(
        email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  UserSignUpParams({
    required this.email,
    required this.password,
  });
}
