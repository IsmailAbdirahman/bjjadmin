import 'package:shared_preferences/shared_preferences.dart';

const String USER_UID_KEY = "uid";

class SharedPref {
  void saveUserUID(String userUID) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(USER_UID_KEY, userUID);
  }

  Future<String> getUserUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uid = preferences.getString(USER_UID_KEY);
    return uid!;
  }

  clearUID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
