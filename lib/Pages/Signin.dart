import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:online_laundary/Pages/HomeScreen.dart';
import 'package:online_laundary/Pages/LoadAlertDialog.dart';
import 'package:online_laundary/Pages/Login.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:page_transition/page_transition.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  bool isloading = false;

  final formKey = GlobalKey<FormState>();

  Future<void> _signin() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      User firebaseUser;

      await _firebaseAuth
          .createUserWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((auth) {
        firebaseUser = auth.user;
      }).catchError((error) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return LoadingAlertDialog(message: error.message.toString());
            });
      });
      if (firebaseUser != null) {
        uploaddata(firebaseUser).then((value) {
          Route route = MaterialPageRoute(builder: (c) => HomeScreen());
          Navigator.pushReplacement(context, route);
        });
      }
    }
  }

  uploaddata(User user) async {
    FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "username": namecontroller.text.trim(),
    });
    SharedPrefernces.sharedPreferences.setString("uid", user.uid);
    SharedPrefernces.sharedPreferences.setString("email", user.email);
    SharedPrefernces.sharedPreferences
        .setString("username", namecontroller.text.trim())
        .then((value) {
      print('Firebase set properly');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
                  child: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/illustration.png'))),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 30),
                      child: Text(
                        'Q',
                        style: GoogleFonts.quando(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(24, 44, 88, 1),
                                fontSize: 50,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        ' uick Wash!',
                        style: GoogleFonts.quando(
                            textStyle: TextStyle(
                                color: Color.fromRGBO(24, 44, 88, 1),
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
                Container(
                  
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(children: [
                        Form(
                          key: formKey,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.length < 4
                                            ? 'Provide a valid username'
                                            : null;
                                      },
                                      controller: namecontroller,
                                      decoration: InputDecoration(
                                        hintText: 'Username :',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      validator: (val) {
                                        return RegExp(
                                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                .hasMatch(val)
                                            ? null
                                            : "Please provide a valid email";
                                      },
                                      controller: emailcontroller,
                                      decoration: InputDecoration(
                                        hintText: 'Email :',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    child: TextFormField(
                                      validator: (val) {
                                        return val.length < 4
                                            ? 'Provide a strong password'
                                            : null;
                                      },
                                      controller: passwordcontroller,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password :',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromRGBO(
                                                    135, 143, 173, 1))),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30, left: 30, right: 30.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      _signin();
                                    },
                                    child: Container(
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(24, 44, 88, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Center(
                                            child: Text('REGISTER'.toUpperCase(),
                                                style: GoogleFonts.lato(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1)))),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageTransition(
                                            child: Login(),
                                            type: PageTransitionType.fade));
                                  },
                                  child: Text(
                                    'Already have an account ? Login',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
