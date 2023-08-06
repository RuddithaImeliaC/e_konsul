import 'package:e_konsul/chatbottomsheet.dart';
import 'package:e_konsul/chatsample.dart';
import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/models/message.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  final Doctor doctor;
  ChatPage({Key? key, required this.doctor}) : super(key: key);

  @override
  createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  List<Message> listMessage = [];

  getMessages() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await prefs.getString('users');
    var key = widget.doctor.doctorKey;
    DatabaseReference m = FirebaseDatabase.instance.ref('chats/${user}_${key}');
    DataSnapshot snap = await m.get();

    // listener
    m.onValue.listen((event) {
      setState(() {
        listMessage.clear();
        var list = event.snapshot.value as List<Object?>;
        list.forEach((valueMessage) {
          var data = valueMessage as Map<dynamic, dynamic>;
          var message = Message.fromSnapshot(data);
          listMessage.add(message);
        });
      });
    });

    if (snap.value != null) {
      setState(() {
        listMessage.clear();
        var list = snap.value as List<Object?>;
        list.forEach((valueMessage) {
          var data = valueMessage as Map<dynamic, dynamic>;
          var message = Message.fromSnapshot(data);
          listMessage.add(message);
        });
      });
    }
  }

  @override
  void initState() {
    getMessages();
    super.initState();
  }

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
                      "Dr. ${widget.doctor.name}",
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
          reverse: true,
          children: [ChatSample(listMessage)],
        ),
        bottomSheet: ChatBottomSheet(doctorKey: widget.doctor.doctorKey));
  }
}
