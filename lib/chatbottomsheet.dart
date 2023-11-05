import 'package:e_konsul/models/recent_chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatBottomSheet extends StatefulWidget {
  final String doctorKey;

  ChatBottomSheet({super.key, required this.doctorKey});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  late TextEditingController typeMessageController = TextEditingController();

  addMessages(BuildContext context) async {
    var msg = context.read<RecentChatData>().typeMessage;
    context.read<RecentChatData>().setTypeMessage('');
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = await prefs.getString('users');
    var key = widget.doctorKey;
    DatabaseReference m = FirebaseDatabase.instance.ref('chats/${user}_${key}');
    DataSnapshot snap = await m.get();

    var objectMsg = {'isDoctor': false, 'value': msg, 'createdAt': DateTime.now().toString()};
    if (snap.value == null || snap.value == '') {
      DatabaseReference c = FirebaseDatabase.instance.ref('chats');
      DataSnapshot snapChat = await c.get();
      var dataChat = snapChat.value as Map<dynamic,dynamic>;
      dataChat['${user}_${key}']= [
        objectMsg
      ];
      c.set(dataChat);
    } else if (snap.value != null) {
      var list = snap.value as List<Object?>;
      list = list.toList();
      list.add(objectMsg);
      m.set(list);
    }
    typeMessageController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ]),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.add,
              color: Color(0xFF113953),
              size: 30,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: 270,
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "Type Something", border: InputBorder.none),
                  onChanged: (value) => {
                    context.read<RecentChatData>().setTypeMessage(value)
                  },
                  controller: typeMessageController,
                ),
              )),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () {
                addMessages(context);
                },
              icon: Icon(
                Icons.send,
                color: Color(0xFF113953),
                size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
