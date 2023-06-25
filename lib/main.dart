
import 'dart:math';

import 'package:e_konsul/chatscreen.dart';
import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:e_konsul/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    FirebaseDatabase.instance.databaseURL = "https://e-konsul-2023-default-rtdb.asia-southeast1.firebasedatabase.app";
  }

  @override
  Widget build(BuildContext context) {
    initFirebase();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/otp': (BuildContext context) => const OtpScreen(),
          '/chatscreen': (BuildContext context) => ChatScreen()
        },
        home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String? usernameErrorText, passwordErrorText;

  signUserIn(context) async {
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
    print(success);
    setState(() async {

      if (!success) {
        usernameErrorText = 'wrong username or password';
        passwordErrorText = 'wrong username or password';
      } else {
        var rng = new Random();
        var otpcode = rng.nextInt(9000) + 1000;
        DatabaseReference users = FirebaseDatabase.instance.ref('users/$username');
        await users.update({
          "otpcode": otpcode,
        });
        usernameErrorText = '';
        passwordErrorText = '';
        Navigator.of(context).pushNamed('/otp');
      }
    });

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(children:
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
                onTap: () {
                  signUserIn(context);
                },
              ),
            ]),
          )),
    );
  }

}