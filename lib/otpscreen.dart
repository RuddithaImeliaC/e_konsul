import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/otp_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(OtpScreen());
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Text(
                    'Verifikasi Kode OTP Anda',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 50),
                  OtpField(),
                  SizedBox(height: 75),
                  MyButton(onTap: signUserIn)
                ],
              ),
            ))));
  }
}
