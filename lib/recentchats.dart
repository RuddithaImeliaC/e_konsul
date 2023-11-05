import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/models/recent_chat.dart';
import 'package:e_konsul/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecentChats extends StatelessWidget {
  final List<Doctor> listDoctor;
  final List<User> listUser;
  final String username;
  final bool isUserDoctor;
  RecentChats(this.listDoctor, this.listUser, this.username, this.isUserDoctor);

  List<Widget> widgetListChat(BuildContext context) {
    List<Widget> l = [];

    if (isUserDoctor == false) {
      var currentUser;
      for (var u in listUser) {
        if (u.username == username) currentUser = u;
      }
      for (var doctor in listDoctor) {
        l.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: InkWell(
            onTap: () {
              context.read<RecentChatData>().setDoctor(doctor);
              context.read<RecentChatData>().setUser(currentUser);
              Navigator.pushNamed(context, "/chatPage");
            },
            child: Container(
                height: 65,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        "images/doc2.png",
                        width: 65,
                        height: 65,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dr. " + doctor.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF113953),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Konsultasi secara online sekarang",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
      }
    }
    else {
      var currentUser;
      for (var u in listDoctor) {
        if (u.doctorKey == username) currentUser = u;
      }
      for (var user in listUser) {
        l.add(Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: InkWell(
            onTap: () {
              context.read<RecentChatData>().setDoctor(currentUser);
              context.read<RecentChatData>().setUser(user);
              Navigator.pushNamed(context, "/chatPage");
            },
            child: Container(
                height: 65,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        "images/doc2.png",
                        width: 65,
                        height: 65,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.nama_lengkap,
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF113953),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Konsultasi secara online sekarang",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ));
      }
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 2),
              ),
            ]),
        child: Column(children: widgetListChat(context)
            // ]
            ));
  }
}
