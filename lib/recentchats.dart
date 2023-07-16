import 'package:flutter/material.dart';

class RecentChats extends StatelessWidget {
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, "chatPage");
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
                              "Dr. Nurlaela Harate",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF113953),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Konsultasi secara online sekarang",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),

                          ],
                        ),
                      ),
                      // Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 10),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [Text("12.30")],
                      //   ),
                      // )
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
