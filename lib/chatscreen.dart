import 'package:e_konsul/models/doctor.dart';
import 'package:e_konsul/recentchats.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen>{
  List<Doctor> listDoctor = [];
  TextEditingController SearchController = new TextEditingController();
  getdoctors (String search) async {
    DatabaseReference doctors = FirebaseDatabase.instance.ref('doctors');
    DataSnapshot snap = await doctors.get();
    if(snap.value != null){
      Map<dynamic, dynamic> databaseDoctors = snap.value as Map<dynamic, dynamic>;
      setState(() {
        listDoctor.clear();
        databaseDoctors.forEach((key, value) {
          var data = value as Map<dynamic, dynamic>;
          data["doctorKey"] = key;
          var doctor = Doctor.fromSnapshot(data);
          if(doctor.name.contains(search)) {
            listDoctor.add(doctor);
          }
        });
      });
    }
  }

  logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.popAndPushNamed(context, "/loginscreen");
  }

  @override
  void initState() {
    // TODO: implement initState
    getdoctors("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(),
      // appBar: AppBar(
          // actions: [
          //   const Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 15),
          //     child: Icon(Icons.notifications),
          //   ),
          // ]
      // ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Text(
              "Message",
              style: TextStyle(
                color: Color(0xFF113953),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 300,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Search", border: InputBorder.none),
                        controller: SearchController,
                        onEditingComplete: () {
                          getdoctors(SearchController.text);
                        },
                      ),
                    ),
                  ),
                  Icon(
                    Icons.search,
                    color: Color(0xFF113953),
                  )
                ],
              ),
            ),
          ),
          // ActiveChats(),
          if(listDoctor.isNotEmpty) RecentChats(listDoctor),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logout();
        },
        backgroundColor: Color(0xFF113953),
        child: Icon(Icons.logout_rounded),
      ),
    );
  }
}

