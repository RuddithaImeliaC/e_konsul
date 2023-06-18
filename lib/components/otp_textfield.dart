import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OtpField extends StatelessWidget {
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
        ),
      ),
      // SizedBox(height: 70),
      // MyButton(onTap: signUserIn)
    ]);
  }
}
