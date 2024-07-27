import 'dart:async';

import 'package:e_konsul/chatbottomsheet.dart';
import 'package:e_konsul/chatsample.dart';
import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/models/message.dart';
import 'package:e_konsul/models/recent_chat.dart';
import 'package:e_konsul/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);

  @override
  createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late Doctor doctor;
  late User user;
  List<Message> listMessage = [];
  late DatabaseReference m;
  late StreamSubscription? listenDb;
  late SharedPreferences prefs;
  late bool? isUserDoctor;
  String headerName = '';

  getMessages(String userKey, String doctorKey) async {
    prefs = await SharedPreferences.getInstance();
    isUserDoctor = prefs.getBool('isUserDoctor');
    if(isUserDoctor == true){
      headerName = user.nama_lengkap;
    } else {
      headerName = "Dr. ${doctor.name}";
    }
    DatabaseReference c = FirebaseDatabase.instance.ref('chats');
    DataSnapshot snapChats = await c.get();

    var chatKey = "${userKey}_$doctorKey";
    m = FirebaseDatabase.instance.ref('chats/$chatKey');
    DataSnapshot snap = await m.get();

    if (snap.value == null) {
      // List list = [];
      var value = snapChats.value as Map<dynamic,dynamic>;
      value[chatKey] = '';
      c.set(value);
    }

    // listener
      listenDb = m.onValue.listen((event) {
        if (!mounted) return;
        setState(() {
          listMessage.clear();
          if (event.snapshot.value != '') {
            var list = event.snapshot.value as List<Object?>;
            list.forEach((valueMessage) {
              var data = valueMessage as Map<dynamic, dynamic>;
              var message = Message.fromSnapshot(data);
              listMessage.add(message);
            });
          }
        });
      });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    listenDb?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    doctor = context.watch<RecentChatData>().doctor;
    user = context.watch<RecentChatData>().user;
    getMessages(user.username, doctor.doctorKey);
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
                      headerName,
                      style: TextStyle(color: Color(0xFF113953)),
                    ),
                  )
                ],
              ),
              actions: [
                // Padding(
                //   padding: EdgeInsets.only(right: 25),
                //   child: Icon(
                //     Icons.call,
                //     color: Color(0xFF113953),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 25),
                //   child: Icon(
                //     Icons.video_call,
                //     color: Color(0xFF113953),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.only(right: 25),
                //   child: Icon(
                //     Icons.more_vert,
                //     color: Color(0xFF113953),
                //   ),
                // )
              ],
            ),
          ),
        ),
        body: ListView(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
          reverse: true,
          children: [ChatSample(listMessage)],
        ),
        bottomSheet: ChatBottomSheet(doctorKey: doctor.doctorKey));
  }
}
