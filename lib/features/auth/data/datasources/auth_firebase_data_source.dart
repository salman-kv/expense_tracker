import 'package:expense_tracker/core/error/exceptions.dart';
import 'package:expense_tracker/features/auth/data/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthFirebaseDataSoures {
  Future<UserModel> signupWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });
  Future<String?> currentUser();
}

class AuthFirebaseDataSouresImpl implements AuthFirebaseDataSoures {
  @override
  Future<UserModel> loginWithEmailPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return UserModel(email: email, password: password);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signupWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return UserModel(email: email, password: password);
    } on ServerException catch (e) {
      throw ServerException(e.message);
    }
  }

  @override
  Future<String?> currentUser() async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      if (sharedPreferences.getString('name') != null ||
          sharedPreferences.getString('name') != '') {
        return sharedPreferences.getString('name');
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
