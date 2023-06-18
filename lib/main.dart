import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
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
                  obscureText: false),
              SizedBox(height: 25),
              MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
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
