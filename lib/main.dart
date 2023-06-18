import 'dart:ffi';

import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyApp();

}
class _MyApp extends State<MyApp> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? usernameErrorText, passwordErrorText;

  void signUserIn() async {
    String username = usernameController.text;
    String password = passwordController.text;
    usernameErrorText = '';
    passwordErrorText = '';
    if (username == '' || password == '') {
      setState(() {
        if (username == '') {
          usernameErrorText = 'username required';
        }
        if (password == '') {
          passwordErrorText = 'password required';
        }
      });
      return;
    }
    var success = await login(username, password);
    setState(() {
      if (!success) {
          usernameErrorText = 'wrong username or password';
          passwordErrorText = 'wrong username or password';
      }
      usernameErrorText = '';
      passwordErrorText = '';
    });
  }

  Future initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseDatabase.instance.databaseURL = "https://e-konsul-2023-default-rtdb.asia-southeast1.firebasedatabase.app";
  }

  Future<bool> login(String username, String password) async {
    DatabaseReference users = FirebaseDatabase.instance.ref('users/$username');
    DataSnapshot snap = await users.get();
    print(snap.value);
    if(snap.value != null) {
      User user = User.fromSnapshot(snap.value as Map<dynamic, dynamic>);
      if(user.password == password) return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    initFirebase();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   title: Text("Welcome", textAlign: TextAlign.center),
          // ),
          body: Center(
              child: Container(
                // child: Container(
                //   child: Image(image: AssetImage('images/logo.jpg')),
                // ),
                // width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                child: Column(children:
                // Image(image: 'images/logo.jpg'),),
                [
                  SizedBox(
                    height: 300,
                    width: 300,
                    child: Image(image: AssetImage("images/logo.jpg")),
                  ),
                  SizedBox(height: 30),
                  Text('E-Konsul Puskesmas Talise',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Bebas',
                      )),
                  SizedBox(height: 25),
                  MyTextField(
                      controller: usernameController,
                      hintText: 'Username',
                      errorText: usernameErrorText,
                      obscureText: false),
                  SizedBox(height: 25),
                  MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      errorText: passwordErrorText,
                      obscureText: true),
                  SizedBox(height: 10),
                  Text(
                    'Belum punya akun? Daftar',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 10),
                  MyButton(
                    onTap: signUserIn,
                  ),
                ]),
              )),
        ));
  }
}