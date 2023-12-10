import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/models/user.dart';
import 'package:flutter/cupertino.dart';

class RecentChatData with ChangeNotifier {
  late Doctor _doctor;
  late User _user;
  String _typeMessage = '';
  bool _isUserDoctor = false;

  Doctor get doctor => _doctor;
  User get user => _user;
  String get typeMessage => _typeMessage;
  bool get isUserDoctor => _isUserDoctor;

  void setDoctor(Doctor d) {
    _doctor = d;
    notifyListeners();
  }

  void setUser(User d) {
    _user = d;
    notifyListeners();
  }

  void setTypeMessage(String d) {
    _typeMessage = d;
    notifyListeners();
  }

  void setIsUserDoctor(bool d) {
    _isUserDoctor = d;
    notifyListeners();
  }
}
