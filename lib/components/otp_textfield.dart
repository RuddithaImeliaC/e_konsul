import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatefulWidget {
  OtpField({super.key, required this.callback});

  Function(String) callback;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  var otpController1 = TextEditingController();
  var otpController2 = TextEditingController();
  var otpController3 = TextEditingController();
  var otpController4 = TextEditingController();
  var otp;
  FocusNode otpController1FocusNode = FocusNode();
  FocusNode otpController2FocusNode = FocusNode();
  FocusNode otpController3FocusNode = FocusNode();
  FocusNode otpController4FocusNode = FocusNode();

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
            sendOtpToParent(context, value);
          },
          focusNode: otpController1FocusNode,
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
            sendOtpToParent(context, value);
          },
          focusNode: otpController2FocusNode,
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
            sendOtpToParent(context, value);
          },
          focusNode: otpController3FocusNode,
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
            sendOtpToParent(context, value);
          },
          focusNode: otpController4FocusNode,
        ),
      ),
      // SizedBox(height: 70),
      // MyButton(onTap: signUserIn)
    ]);
  }

  sendOtpToParent(context, newValue) {
    if(newValue != '') {
      if (otpController1.text != '' && otpController2.text == '' &&
          otpController3.text == '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController2FocusNode);
      } else if (otpController1.text != '' && otpController2.text != '' &&
          otpController3.text == '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController3FocusNode);
      } else if (otpController1.text != '' && otpController2.text != '' &&
          otpController3.text != '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController4FocusNode);
      }
    }

    else if(newValue == '') {
      if (otpController1.text != '' && otpController2.text != '' &&
          otpController3.text != '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController3FocusNode);
      } else if (otpController1.text != '' && otpController2.text != '' &&
          otpController3.text == '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController2FocusNode);
      } else if (otpController1.text != '' && otpController2.text == '' &&
          otpController3.text == '' && otpController4.text == '') {
        FocusScope.of(context).requestFocus(otpController1FocusNode);
      }
    }

    otp = otpController1.text + otpController2.text + otpController3.text +
        otpController4.text;
    widget.callback(otp);
  }

}
