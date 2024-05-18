import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/core/common/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String email, required String password});
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password});
  Future<Either<Failure,String>> currentUser();
}
