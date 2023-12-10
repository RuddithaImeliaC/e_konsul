import 'dart:math';

import 'package:e_konsul/chatpage.dart';
import 'package:e_konsul/chatscreen.dart';
import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:e_konsul/models/recent_chat.dart';
import 'package:e_konsul/otpscreen.dart';
import 'package:e_konsul/registerscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';

import 'models/user.dart';

bool? prefUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitFirebase();
  prefUser = await isLoggedIn();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => RecentChatData()),
        ],
        child: const MyApp(),
      )
  );
}

InitFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseDatabase.instance.databaseURL =
      "https://e-konsul-2023-default-rtdb.asia-southeast1.firebasedatabase.app";
}

isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var isLoggedIn = await prefs.getBool('isLoggedIn');
  return isLoggedIn;
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
        '/registerscreen': (BuildContext context) => RegisterScreen(),
        '/loginscreen': (BuildContext context) => LoginScreen(),
        '/chatPage': (BuildContext context) => ChatPage()
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   var routes = <String, WidgetBuilder>{
      //     "/chatPage": (ctx) => ChatPage(doctor: settings.arguments as Doctor),
      //   };
      //   WidgetBuilder? builder = routes[settings.name];
      //   return MaterialPageRoute(builder: (ctx) => builder!(ctx));
      // },
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
  late DatabaseReference users;
  late SharedPreferences prefs;

  signUserIn(BuildContext context) async {
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
    var success = await login(context, username, password);
    print(success);
    if (!success) {
      setState(() {
        usernameErrorText = 'wrong username or password';
        passwordErrorText = 'wrong username or password';
      });
    } else {
      var rng = new Random();
      var otpcode = rng.nextInt(9000) + 1000;
      print(otpcode);
      // users = FirebaseDatabase.instance.ref('users/$username');
      await users.update({
        "otpcode": otpcode,
      });
      // final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('users', username);
      setState(() {
        usernameErrorText = '';
        passwordErrorText = '';
      });
      Navigator.of(context).pushNamed('/otp');
    }
  }

  Future<bool> login(BuildContext context, String username, String password) async {
    users = FirebaseDatabase.instance.ref('users/$username');
    DataSnapshot snap = await users.get();
    print(snap.value);
    if (snap.value != null) {
      User user = User.fromSnapshot(snap.value as Map<dynamic, dynamic>);
      if (user.password == password) {
        setUserSession(context, username, false);
        return true;
      }
    }

    print("find doctors");
    // if user not found cek doctor user
    users = FirebaseDatabase.instance.ref('doctors/$username');
    snap = await users.get();
    if (snap.value != null) {
      User user = User.fromSnapshot(snap.value as Map<dynamic, dynamic>);
      if (user.password == password) {
        setUserSession(context, username, true);
        return true;
      }
    }

    return false;
  }

  setUserSession(BuildContext context, String username, bool isUserDoctor) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('users', username);
    prefs.setBool('isUserDoctor', isUserDoctor);
    context.read<RecentChatData>().setIsUserDoctor(isUserDoctor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        child :SingleChildScrollView(

        padding: const EdgeInsets.all(8),
        child: Column(children: [
          SizedBox(
            height: 300,
            width: 300,
            child: Image(image: AssetImage("images/logo.jpg")),
          ),
          SizedBox(height: 10),
          Text('E-Konsul Puskesmas Talise',
              style: TextStyle(
                color: Color(0xFF113953),
                fontSize: 28,
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
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/registerscreen");
                },
                child: new Text(
                  'Belum punya akun? Daftar',
                  style: TextStyle(color: Color(0xFF113953),
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
          SizedBox(height: 10),
          MyButton(
            onTap: () {
              signUserIn(context);
            },
          ),
        ]),
      )),
    ));
  }
}
