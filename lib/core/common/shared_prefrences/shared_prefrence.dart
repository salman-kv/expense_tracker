import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesClass{

  // seting user email in shared prefrence
  
  static setUserEmail(String userEmail)async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('name', userEmail);
  }


  // removing name from shared prefrence

  static deleteUserEmail()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    sharedPreferece.setString('name', '');
  }

  // getting user name from shared prefrence

  static getUserEmail()async{
    final sharedPreferece= await SharedPreferences.getInstance();
    return sharedPreferece.getString('name');
  }

}