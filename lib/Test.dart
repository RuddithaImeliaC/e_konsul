import 'package:e_konsul/chatpage.dart';
import 'package:e_konsul/chatscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Test());
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xFFF5F5F3),
          appBarTheme: AppBarTheme(
              backgroundColor: Color(0xFFF5F5F3),
              foregroundColor: Colors.black)),
      routes: {
        "/": (context) => ChatScreen(),
        "chatPage": (context) => ChatPage()
      },
    );
  }
}
