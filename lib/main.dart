
import 'dart:math';

import 'package:e_konsul/chatpage.dart';
import 'package:e_konsul/chatscreen.dart';
import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/otpscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/user.dart';

String? prefUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitFirebase();
  prefUser = await isLoggedIn();
  runApp(const MyApp());
}

InitFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.databaseURL = "https://e-konsul-2023-default-rtdb.asia-southeast1.firebasedatabase.app";
}

isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var users = await prefs.getString('users');
  return users;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/otp': (BuildContext context) => OtpScreen(),
          '/chatscreen': (BuildContext context) => ChatScreen(),
          // '/chatPage': (BuildContext context) => ChatPage()
        },
        onGenerateRoute: (RouteSettings settings) {
          var routes = <String, WidgetBuilder>{
            "/chatPage": (ctx) => ChatPage(doctor: settings.arguments as Doctor),
          };
          WidgetBuilder? builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder!(ctx));
        },
        home: (prefUser != null) ? ChatScreen() : LoginScreen(),
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
        print(otpcode);
        DatabaseReference users = FirebaseDatabase.instance.ref('users/$username');
        await users.update({
          "otpcode": otpcode,
        });
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('users', username);
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