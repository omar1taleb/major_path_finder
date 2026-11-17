class UserModel {
  String name;
  String email;
  String password;
  String gender;
  String track;
  bool isDarkMode;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
    required this.track,
    required this.isDarkMode,
  });
}