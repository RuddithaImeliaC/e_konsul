import 'package:e_konsul/chatbottomsheet.dart';
import 'package:e_konsul/chatsample.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: EdgeInsets.only(top: 5),
            child: AppBar(
              leadingWidth: 30,
              title: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "images/doc1.png",
                      height: 45,
                      width: 45,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "Dr. Nurlaela ",
                      style: TextStyle(color: Color(0xFF113953)),
                    ),
                  )
                ],
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Icon(
                    Icons.call,
                    color: Color(0xFF113953),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Icon(
                    Icons.video_call,
                    color: Color(0xFF113953),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 25),
                  child: Icon(
                    Icons.more_vert,
                    color: Color(0xFF113953),
                  ),
                )
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          children: [ChatSample()],
        ),
        bottomSheet: ChatBottomSheet());
  }
}
