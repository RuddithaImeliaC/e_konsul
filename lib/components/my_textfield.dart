import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? errorText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.errorText,
  });

  @override
  createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  late bool obscureText;
  Widget? suffixIcon;

  @override
  void initState() {
    super.initState();
    obscureText = false;
    if (widget.obscureText) {
      obscureText = true;
    }
  }

    @override
  Widget build(BuildContext context) {
    if (widget.obscureText) {
      suffixIcon = IconButton(
        icon: Icon(
          // Based on passwordVisible state choose the icon
          obscureText
              ? Icons.visibility
              : Icons.visibility_off,
        ),
        onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
            obscureText = !obscureText;
          });
        },
      );
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: TextField(
          controller: widget.controller,
          obscureText: obscureText,
          decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
              fillColor: Colors.white,
              filled: true,
              hintText: widget.hintText,
              errorText: widget.errorText,
              hintStyle: TextStyle(color: Colors.grey[500]),
              suffixIcon: suffixIcon
          ),
        ));
  }
}
