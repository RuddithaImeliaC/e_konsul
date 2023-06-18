import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/my_textfield.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfilePageState());
}

void signUserIn() {}

class ProfilePageState extends StatelessWidget {
  ProfilePageState({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(children: [
                    SizedBox(height: 5),
                    Image(image: AssetImage("images/login.jpg")),
                    SizedBox(height: 20),
                    Text('Daftar Akun',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 15),
                    MyTextField(
                        controller: usernameController,
                        hintText: 'Nama Lengkap',
                        obscureText: false),
                    SizedBox(height: 15),
                    MyTextField(
                        controller: usernameController,
                        hintText: 'Tempat Tanggal Lahir',
                        obscureText: false),
                    SizedBox(height: 15),
                    MyTextField(
                        controller: usernameController,
                        hintText: 'Alamat',
                        obscureText: false),
                    SizedBox(height: 15),
                    MyTextField(
                        controller: usernameController,
                        hintText: 'Username',
                        obscureText: false),
                    SizedBox(height: 15),
                    MyTextField(
                        controller: usernameController,
                        hintText: 'Password',
                        obscureText: true),
                    SizedBox(height: 20),
                    MyButton(
                      onTap: signUserIn,
                    ),
                  ])))),
    );
  }
}
