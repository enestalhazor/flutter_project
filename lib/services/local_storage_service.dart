import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  Future<void> saveData(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", username);
    print("$username name saved");
  }

  Future<String> getData() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString("username") ?? "";
  }

   Future<void> clearData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("username");
  }


}
