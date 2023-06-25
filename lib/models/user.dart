
class User {
  String username;
  String password;
  late int otpcode;

  User({required this.username, required this.password});

  User.fromSnapshot(Map<dynamic, dynamic> data) :
    username = data['username'] ?? '',
    password = data['password'] ?? '';

}
