import 'package:firebase_database/firebase_database.dart';

class User {
  String username;
  String password;

  User({required this.username, required this.password});

  User.fromSnapshot(Map<dynamic, dynamic> data) :
    username = data['username'] ?? '',
    password = data['password'] ?? '';

}
