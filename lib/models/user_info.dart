class UserInfo {
  final String name;
  final int gender;
  final List<String> colors;
  final bool isStudent;

  UserInfo(
      {required this.name,
      required this.gender,
      required this.colors,
      required this.isStudent});

  @override
  String toString() {
    return "name: $name, gender: $gender, colors: $colors, isStudent: $isStudent";
  }
}
