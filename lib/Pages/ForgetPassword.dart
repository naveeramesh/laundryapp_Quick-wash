import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

class Forget extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  String email = "";
  TextEditingController emailcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color.fromRGBO(135, 143, 173, 1),
          title: Text('RESET PASSWORD',
              style: GoogleFonts.quando(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold)))),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/illustration.png'))),
            ),
            Center(
              child: Text(
                'Quick Wash',
                style: GoogleFonts.quando(
                  textStyle: TextStyle(
                      color: Color.fromRGBO(24, 44, 88, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    cursorColor: Color.fromRGBO(135, 143, 173, 1),
                    controller: emailcontroller,
                    style: TextStyle(color: Colors.black),
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color.fromRGBO(135, 143, 173, 1),
                        )),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                          borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1),
                          ),
                        ),
                        hintText: "Email :",
                        hintStyle: GoogleFonts.quando(
                            textStyle: TextStyle(
                          color: Colors.grey,
                        ))),
                  ),
                )),
            GestureDetector(
              onTap: () {
                mail();
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0, left: 50, right: 50),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(24, 44, 88, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text('SEND LINK ',
                        style: GoogleFonts.quando(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  mail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).whenComplete(() {
      Toast.show("Check the mail", context,
          backgroundColor: Color.fromRGBO(135, 143, 173, 1),
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    });
  }
}
