// import 'package:e_konsul/styles/button.dart';
// import 'package:e_konsul/components/chat_button.dart';
import 'package:flutter/material.dart';

class HomeIcon extends StatelessWidget {
  void chatUser() {}
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const ListTile(
          title: Text(
            "REKOMENDASI DOKTER",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          subtitle: Text("Konsultasi Online dengan dokter siaga kami"),
        ),
        const ListTile(
          title: Text("Dr.Nurlaela Harate"),
          subtitle: Text("Dokter Umum"),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/doc1.png'),
          ),
        ),
        Column(
          children: [
            ElevatedButton(
              // style: buttonPrimary,
              onPressed: chatUser,
              child: Text('Chat'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  primary: Colors.lightBlueAccent,
                  onPrimary: Colors.white,
                  // backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            ElevatedButton.icon(
              onPressed: chatUser,
              icon: Icon(Icons.chat),
              label: Text('Chat dengan Dokter'),
            ),
          ],
        ),
        const ListTile(
          title: Text("Dr.Nurlaela Harate"),
          subtitle: Text("Dokter Umum"),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/doc2.png'),
          ),
        ),

        Column(
          children: [
            ElevatedButton(
              // style: buttonPrimary,
              onPressed: chatUser,
              child: Text('Chat'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  primary: Colors.lightBlueAccent,
                  onPrimary: Colors.white,
                  // backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),

        // ),

        const ListTile(
          title: Text("Dr.Nurlaela Harate"),
          subtitle: Text("Dokter Umum"),
          leading: CircleAvatar(
            backgroundImage: AssetImage('images/doc3.png'),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              // style: buttonPrimary,
              onPressed: chatUser,
              child: Text('Chat'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(50, 50),
                  primary: Colors.lightBlueAccent,
                  onPrimary: Colors.white,
                  // backgroundColor: Colors.lightBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ],
        ),
      ],
    );
  }
}
