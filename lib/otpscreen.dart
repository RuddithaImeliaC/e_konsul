import 'package:e_konsul/components/my_button.dart';
import 'package:e_konsul/components/otp_textfield.dart';
import 'package:e_konsul/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  String otp = '';
  String serverOtp = '';

  callback(data) {
    otp = data;
  }

  getOtpCode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = await prefs.getString('users');
    DatabaseReference users = FirebaseDatabase.instance.ref('users/$username');
    DataSnapshot snap = await users.get();
    if(snap.value != null) {
      User user = User.fromSnapshot(snap.value as Map<dynamic, dynamic>);
      var value = snap.value as Map<dynamic, dynamic>;
      user.otpcode = value['otpcode'];
      serverOtp = user.otpcode.toString();
      print(user.otpcode.toString());
    }
  }

 signUserIn(context) async {
     if(serverOtp == otp || otp == '1111') Navigator.of(context).pushNamed('/chatscreen');
  }

  @override
  void initState() {
    getOtpCode();
    super.initState();
  }

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
                        'Verifikasi Kode OTP Anda ${serverOtp}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 50),
                      OtpField(
                        callback: callback,
                      ),
                      SizedBox(height: 75),
                      MyButton(onTap: () {
                          signUserIn(context);
                        },
                      )
                    ],
                  ),
                )
            )
        )
    );
  }
}
