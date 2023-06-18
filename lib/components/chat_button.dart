import 'package:flutter/material.dart';

class ChatButton extends StatelessWidget {
  final Function()? onTap;

  const ChatButton({super.key, required this.onTap});
  void chatUser() {}
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      // style: buttonPrimary,
      onPressed: chatUser,
      child: Text('Chat'),
      style: ElevatedButton.styleFrom(
          minimumSize: Size(100, 50),
          primary: Colors.lightBlueAccent,
          onPrimary: Colors.lightBlue,
          // backgroundColor: Colors.lightBlue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
    ));
  }
}
