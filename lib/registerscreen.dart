import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void signUserIn() {}

class RegisterScreen extends StatefulWidget {


  @override
  createState() => RegisterScreenState();
}
class RegisterScreenState extends State<RegisterScreen>{

  final nameController = TextEditingController();
  final ttlController = TextEditingController();
  final alamatController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  var errormsg='';


  registerUser() async {
    if (nameController.text == '' || ttlController.text == '' || alamatController.text == '' || usernameController.text == '' || passwordController.text == '') {
      setState(() {
        errormsg='Data belum lengkap';
      });
      return;

    }
    setState(() {
      errormsg='';
    });

    DatabaseReference m = FirebaseDatabase.instance.ref('users/${usernameController.text}');
    DataSnapshot snap = await m.get();
    if (snap.value == null || snap.value == '') {
      Map<dynamic,dynamic> dataUser={} ;
      dataUser['nama_lengkap']=nameController.text;
      dataUser['tempat_tgl_lahir']=ttlController.text;
      dataUser['alamat']=alamatController.text;
      dataUser['username']=usernameController.text;
      dataUser['password']=passwordController.text;
      m.set(dataUser);
      nameController.clear();
      ttlController.clear();
      alamatController.clear();
      usernameController.clear();
      passwordController.clear();
      Navigator.pop(context);
    } else if (snap.value != null) {
      setState(() {
        errormsg='akun telah terdaftar';
      });
    }

    FocusManager.instance.primaryFocus?.unfocus();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                  child: Column(children: [
                    // SizedBox(height: 5),
                    // Image(image: AssetImage("images/login.jpg")),
                    SizedBox(height: 20),
                    Text('Daftar Akun',
                        style: TextStyle(
                          color: Color(0xFF113953),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(height: 15),
                    TextField(
                      controller: nameController,
                          textAlign: TextAlign.start,
                          style:  TextStyle(fontSize: 20, color: Color(0xFF113953),
                          ),
                          decoration: InputDecoration(
                            label: Text("Nama Lengkap"),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            hintText: "Masukkan Nama Lengkap",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)
                              ),
                              borderSide: BorderSide(color: Color(0xFF113953))
                            )
                          )),

                    SizedBox(height: 15),
                    TextField(
                      controller: ttlController,
                      textAlign: TextAlign.start,
                      style:  TextStyle(fontSize: 20, color: Color(0xFF113953),
                      ),
                      decoration: InputDecoration(
                          label: Text("Tanggal Lahir"),
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)
                              ),
                              borderSide: BorderSide(color: Color(0xFF113953))
                          )
                      ),
                      readOnly: true,  //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context, initialDate: DateTime.now(),
                            firstDate: DateTime(1900), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime.now(),
                        );

                        if(pickedDate != null ){
                          print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            ttlController.text = formattedDate; //set output date to TextField value.
                          });
                        }else{
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: alamatController,
                        textAlign: TextAlign.start,
                        style:  TextStyle(fontSize: 20, color: Color(0xFF113953),
                        ),
                        decoration: InputDecoration(
                            label: Text("Alamat"),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            hintText: "Masukkan Alamat Lengkap",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)
                                ),
                                borderSide: BorderSide(color: Color(0xFF113953))
                            )
                        )
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: usernameController,
                        textAlign: TextAlign.start,
                        style:  TextStyle(fontSize: 20, color: Color(0xFF113953),
                        ),
                        decoration: InputDecoration(
                            label: Text("Username"),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            hintText: "Masukkan Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)
                                ),
                                borderSide: BorderSide(color: Color(0xFF113953))
                            )
                        )
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: passwordController,
                        textAlign: TextAlign.start,
                        obscureText: true,
                        style:  TextStyle(fontSize: 20, color: Color(0xFF113953),
                        ),
                        decoration: InputDecoration(
                            label: Text("Password"),
                            contentPadding: EdgeInsets.symmetric(horizontal: 20),
                            hintText: "Masukkan Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)
                                ),
                                borderSide: BorderSide(color: Color(0xFF113953))
                            )
                        )
                    ),
                    SizedBox(height: 20),
                    Text(errormsg),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: registerUser,
                        child: Text('Daftar'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(20.0),
                      fixedSize: Size(150, 75),
                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      primary: Color(0xFF113953),
                      onPrimary: Colors.white,
                      elevation: 15,
                      shadowColor: Color(0xFF113953),
                      shape: StadiumBorder()

                    ),
                    )
              ]))))),
    );
  }
}
