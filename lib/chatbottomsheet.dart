import 'dart:io';
import 'dart:async';

import 'package:e_konsul/models/recent_chat.dart';
import 'package:e_konsul/models/user.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/doctor.dart';

class ChatBottomSheet extends StatefulWidget {
  final String doctorKey;

  ChatBottomSheet({super.key, required this.doctorKey});

  @override
  State<ChatBottomSheet> createState() => _ChatBottomSheetState();
}

class _ChatBottomSheetState extends State<ChatBottomSheet> {
  late TextEditingController typeMessageController = TextEditingController();

  addMessages(Doctor doctor, User user, String? receipt, List<Object?> chats) async {
    var msg = context.read<RecentChatData>().typeMessage;
    String? file;
    if (receipt != null) {
      msg = 'receipt';
      file = receipt;
    }
    context.read<RecentChatData>().setTypeMessage('');

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var isUserDoctor = prefs.getBool('isUserDoctor');

    var chatKey = "${user.username}_${doctor.doctorKey}";
    DatabaseReference m = FirebaseDatabase.instance.ref('chats/$chatKey');

    var objectMsg = {'isDoctor': isUserDoctor, 'value': msg, 'createdAt': DateTime.now().toString()};
    if (file != null) objectMsg['file'] = file;

    var list = chats.toList();
    list.add(objectMsg);
    m.set(list);

    typeMessageController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<List<Object?>> getChats(Doctor doctor, User user) async {
    var chatKey = "${user.username}_${doctor.doctorKey}";
    DatabaseReference m = FirebaseDatabase.instance.ref('chats/$chatKey');
    DataSnapshot snap = await m.get();

    List<Object?> res = List.empty();

    if (snap.value == null || snap.value == '') {
      DatabaseReference c = FirebaseDatabase.instance.ref('chats');
      Map<dynamic,dynamic> val = {chatKey:[]};
      c.set(val);
    } else {
      var list = snap.value as List<Object?>;
      res = list.toList();
    }

    return res;
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String?> uploadPic(Doctor doctor, User user, List<Object?> chats) async {
    var chatKey = "${user.username}_${doctor.doctorKey}";
    final ImagePicker picker = ImagePicker();

    //Get the file from the image picker and store it
    var image = await picker.pickImage(source: ImageSource.gallery);
    var file = File(image!.path);

    var length = chats.length+1;
    //Create a reference to the location you want to upload to in firebase
    var reference = _storage.ref().child("images/$chatKey/$length.jpg");

    //Upload the file to firebase
    try {
      await reference.putFile(file,SettableMetadata(contentType: "image/jpg"));
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }

    // Waits till the file is uploaded then stores the download url
    var location = reference.getDownloadURL();

    //returns the download url
    return location;
  }

  @override
  Widget build(BuildContext context) {
    var doctor = context.read<RecentChatData>().doctor;
    var user = context.read<RecentChatData>().user;
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
            child: IconButton(
              onPressed: () async {
                var chats = await getChats(doctor,user);
                var receipt = await uploadPic(doctor,user,chats);
                if (receipt != null) addMessages(doctor,user,receipt,chats);
              },
              icon: const Icon(
                Icons.add,
                color: Color(0xFF113953),
                size: 30,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 10),
              child: Container(
                alignment: Alignment.centerRight,
                width: 270,
                child: TextFormField(
                  decoration: const InputDecoration(
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
              onPressed: () async {
                var chats = await getChats(doctor,user);
                addMessages(doctor,user,null,chats);
              },
              icon: const Icon(
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
