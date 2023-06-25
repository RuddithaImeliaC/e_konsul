import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {

  var otpController1 = TextEditingController();
  var otpController2 = TextEditingController();
  var otpController3 = TextEditingController();
  var otpController4 = TextEditingController();
  var otp;

  Function(String) callback;

  OtpField({super.key, required this.callback});

  sendOtpToParent() {
    otp = otpController1.text + otpController2.text + otpController3.text +
        otpController4.text;
    callback(otp);
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(padding: EdgeInsets.all(1)),
      // Column(
      //   children: [
      // SizedBox(
      //   height: 50,
      // ),
      // Text("Verifikasi Kode OTP"),
      //   ],
      // ),
      SizedBox(
        height: 68,
        width: 64,
        child: TextField(
          // style: Theme.of(context.textTheme.headline6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            // FilteringTextInputFormatter.digitsOnly,
          ],
          controller: otpController1,
          onChanged: (value) {
            sendOtpToParent();
          },
        ),
      ),
      SizedBox(
        height: 68,
        width: 64,
        child: TextField(
          // style: Theme.of(context.textTheme.headline6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            // FilteringTextInputFormatter.digitsOnly,
          ],
          controller: otpController2,
          onChanged: (value) {
            sendOtpToParent();
          },
        ),
      ),
      SizedBox(
        height: 68,
        width: 64,
        child: TextField(
          // style: Theme.of(context.textTheme.headline6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            // FilteringTextInputFormatter.digitsOnly,
          ],
          controller: otpController3,
          onChanged: (value) {
            sendOtpToParent();
          },
        ),
      ),
      SizedBox(
        height: 68,
        width: 64,
        child: TextField(
          // style: Theme.of(context.textTheme.headline6,
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            // FilteringTextInputFormatter.digitsOnly,
          ],
          controller: otpController4,
          onChanged: (value) {
            sendOtpToParent();
          },
        ),
      ),
      // SizedBox(height: 70),
      // MyButton(onTap: signUserIn)
    ]);
  }
}
