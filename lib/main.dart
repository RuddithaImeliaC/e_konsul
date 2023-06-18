import 'package:flutter/material.dart';

late Size mq;
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   title: Text("Welcome", textAlign: TextAlign.center),
          // ),
          body: Center(
              child: Container(
            // child: Container(
            //   child: Image(image: AssetImage('images/logo.jpg')),
            // ),
            // width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            child: Column(children:
                // Image(image: 'images/logo.jpg'),),
                const [
              SizedBox(height: 50),
              Icon(
                Icons.local_hospital_rounded,
                size: 150,
              ),
              SizedBox(height: 50),
              Text('E-Konsul Puskesmas Talise',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'Bebas',
                  )),
              SizedBox(height: 25),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0)),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              SizedBox(height: 25),
              Padding(padding: const EdgeInsets.symmetric(horizontal: 25.0)),
              TextField(
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  fillColor: Colors.white,
                  filled: true,
                ),
              )
            ]),
          )),
        ));
  }
}
