import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:storage/const.dart';
import 'package:storage/models/user_info.dart';
import 'package:storage/services/shared_pref_service.dart';

class SharedPref extends StatefulWidget {
  const SharedPref({Key? key}) : super(key: key);

  @override
  State<SharedPref> createState() => _SharedPrefState();
}

class _SharedPrefState extends State<SharedPref> {
  final sharedPreferencesService = SharedPreferencService();
  final _textFieldController = TextEditingController();

  Gender? _gender = Gender.MALE;

  bool _switchState = false;

  late List<String> _selectedColors = [];

  @override
  void initState() {
    _getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared Preferences'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: TextField(
              onChanged: ((value) {
                if (kDebugMode) {
                  print("TextField: ${_textFieldController.text}");
                }
              }),
              controller: _textFieldController,
              decoration: const InputDecoration(
                labelText: "Enter Your Name",
              ),
            ),
          ),
          for (var i in Gender.values) myRadio(i),
          for (var i in MyColors.values) myCheckBox(color: i),
          SwitchListTile(
              title: const Text("Is He/She Student?"),
              value: _switchState,
              onChanged: (value) {
                _switchState = value;
                if (kDebugMode) {
                  print("is he student?: $_switchState");
                }
                setState(() {});
              }),
          TextButton(
              onPressed: () {
                sharedPreferencesService.saveDatas(UserInfo(
                    name: _textFieldController.text,
                    gender: _gender!.index,
                    colors: _selectedColors,
                    isStudent: _switchState));
              },
              child: const Text("Kaydet"))
        ],
      ),
    );
  }

  CheckboxListTile myCheckBox({required MyColors color}) {
    return CheckboxListTile(
        title: Text(describeEnum(color)),
        value: _selectedColors.contains(describeEnum(color)),
        onChanged: (value) {
          if (value!) {
            _selectedColors.add(describeEnum(color));
          } else if (_selectedColors.contains(describeEnum(color))) {
            _selectedColors.remove(describeEnum(color));
          }

          setState(() {
            debugPrint("List: $_selectedColors");
          });
        });
  }

  RadioListTile<Gender> myRadio(Gender gender) {
    return RadioListTile<Gender>(
        groupValue: _gender,
        title: Text(describeEnum(gender)),
        value: gender,
        onChanged: ((value) {
          _gender = value;

          debugPrint("Gender: ${describeEnum(_gender!)}");

          setState(() {});
        }));
  }

  _getData() async {
    final UserInfo userInfo = await sharedPreferencesService.getDatas();
    _textFieldController.text = userInfo.name;
    _gender = Gender.values[userInfo.gender];
    _selectedColors = userInfo.colors;
    _switchState = userInfo.isStudent;
    setState(() {});
  }
}
