import 'package:expense_tracker/core/common/entities/user_entity.dart';
import 'package:expense_tracker/core/error/failures.dart';
import 'package:expense_tracker/features/auth/data/datasources/auth_firebase_data_source.dart';
import 'package:expense_tracker/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSoures authFirebaseDataSoures;
  const AuthRepositoryImpl(this.authFirebaseDataSoures);
  @override
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final res = await authFirebaseDataSoures.loginWithEmailPassword(
          email: email, password: password);
      return right(res);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> signupWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await authFirebaseDataSoures.signupWithEmailPassword(
          email: email, password: password);
      return right(User(email: email, password: password));
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> currentUser() async {
    try {
      final res = await authFirebaseDataSoures.currentUser();
      if (res != null) {
        return right(res);
      } else {
        return left(Failure(message: 'No user found'));
      }
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
