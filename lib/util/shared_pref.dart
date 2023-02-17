import 'package:shared_preferences/shared_preferences.dart';

class PrefManagement {
  static SharedPreferences? pref;
  static const String _isLoggedIn = "is-logged-in";
  static const String _userId ="user-id";

  static Future<void> init() async {
    pref ??= await SharedPreferences.getInstance();
  }
  static void setLoggedIn(bool value){
    pref!.setBool(_isLoggedIn, value);
  }
  static bool? getLoggedIn(){
    return pref!.getBool(_isLoggedIn);
  }
  static void setUserId(int value){
    pref!.setInt(_userId, value);
  }
  static int? getUserId(){
    return pref!.getInt(_userId);
  }
  static void prefClear(){
    pref!.clear();
  }
}
