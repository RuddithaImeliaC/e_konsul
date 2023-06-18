import 'package:e_konsul/components/home_icon.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, home: Scaffold(body: HomeIcon()));
    // backgroundColor: Colors.white,
    // body: Center(
    //   child: Container(
    //     padding: const EdgeInsets.all(8),
    //     child: Column(
    //       children: [
    //         const SizedBox(height: 30),
    //         Text(
    //           'WELCOME',
    //           style: TextStyle(
    //               fontSize: 50,
    //               color: Colors.lightBlue,
    //               fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(height: 10),
    //         Text(
    //           'Rekomendasi Dokter',
    //           textAlign: TextAlign.left,
    //           style:
    //               TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //         ),
    //         const SizedBox(height: 10),
    //         Text('Konsultasi online dengan dokter siaga kami'),
    //         const SizedBox(height: 10),
    //         HomeIcon(),
    //         // SizedBox(height: 10),
    //         // Image(image: AssetImage('images/doc1.png')),
    //         // SizedBox(height: 10),
    //         // Image(image: AssetImage('images/doc2.png')),
    //         // SizedBox(height: 10),
    //         // Image(image: AssetImage('images/doc3.png')),
    //       ],
    //     ),
    //   ),
    // )));
  }
}
