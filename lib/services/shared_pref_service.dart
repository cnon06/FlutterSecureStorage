
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage/const.dart';
import 'package:storage/models/user_info.dart';

class SharedPreferencService {
  saveDatas(UserInfo userInfo) async {
    final flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.write(key: "name", value: userInfo.name);
    await flutterSecureStorage.write(
        key: "gender", value: userInfo.gender.toString());
    await flutterSecureStorage.write(
        key: "color", value: jsonEncode(userInfo.colors));
    await flutterSecureStorage.write(
        key: "isStudent", value: userInfo.isStudent.toString());

    
    
  }

  Future<UserInfo> getDatas() async {
    final preferences = FlutterSecureStorage();

    final name = await preferences.read(key: "name") ?? "";
    final genderIndex = int.parse(await preferences.read(key: "gender") ?? "0");
    final gender = Gender.values[genderIndex];
    final colorString = await preferences.read(key: "color") ?? "[]";
    final colors = List<String>.from(jsonDecode(colorString));

    final iStudentString = await preferences.read(key: "isStudent") ?? "false";
    final isStudent = iStudentString.toLowerCase()  == "true" ? true : false;

    
    
    
    

    return UserInfo(
        name: name, gender: gender.index, colors: colors, isStudent: isStudent);
  }
}
