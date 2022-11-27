import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/const.dart';
import 'package:storage/models/user_info.dart';

class SharedPreferencService {
  saveDatas(UserInfo userInfo) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setString("name", userInfo.name);
    preferences.setInt("gender", userInfo.gender);
    preferences.setStringList("color", userInfo.colors);
    preferences.setBool("isStudent", userInfo.isStudent);
  }

  Future<UserInfo> getDatas() async {
    final preferences = await SharedPreferences.getInstance();
    final name = preferences.getString("name") ?? "";
    final gender = Gender.values[preferences.getInt("gender") ?? 0];
    final colors = preferences.getStringList("color") ?? <String>[];
    final isStudent = preferences.getBool("isStudent") ?? false;

    return UserInfo(
        name: name, gender: gender.index, colors: colors, isStudent: isStudent);
  }
}
