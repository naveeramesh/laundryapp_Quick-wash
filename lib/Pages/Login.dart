import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Pages/ForgetPassword.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:page_transition/page_transition.dart';
import 'ErrorAlertDialog.dart';
import 'HomeScreen.dart';
import 'Signin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isloading = false;
  String word;

  final formKey = GlobalKey<FormState>();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  Future<void> _login() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isloading = true;
      });
      User firebaseUser;

      await _firebaseAuth
          .signInWithEmailAndPassword(
              email: emailcontroller.text.trim(),
              password: passwordcontroller.text.trim())
          .then((auth) {
        firebaseUser = auth.user;
      }).catchError((error) {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (c) {
              return ErrorAlertDialog(message: error.message.toString());
            });
      });
      if (firebaseUser != null) {
        readdata(firebaseUser).then((value) {
          Route route = MaterialPageRoute(builder: (c) => HomeScreen());
          Navigator.pushReplacement(context, route);
        });
      }
    }
  }

  readdata(User fuser) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(fuser.uid)
        .get()
        .then((dataSnapshot) async {
      print(dataSnapshot.data()['uid']);
      print(dataSnapshot.data()['email']);
      word = dataSnapshot.data()['username'];
      print(word);
      await SharedPrefernces.sharedPreferences
          .setString("username", dataSnapshot.data()["username"]);
      await SharedPrefernces.sharedPreferences
          .setString("uid", dataSnapshot.data()["uid"]);
      await SharedPrefernces.sharedPreferences
          .setString("email", dataSnapshot.data()["email"]);
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
                height: 100,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/illustration.png'))),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20),
                          child: Text(
                            'W',
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
                            'elcome back to Quick wash !',
                            style: GoogleFonts.quando(
                                textStyle: TextStyle(
                                    color: Color.fromRGBO(24, 44, 88, 1),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(children: [
                      Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30.0, right: 30),
                          child: Column(
                            children: [
                              Container(
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
                                    hintStyle: TextStyle(color: Colors.grey),
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
                                      hintStyle: TextStyle(color: Colors.grey),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              child: Forget(),
                                              type: PageTransitionType.fade));
                                    },
                                    child: Container(
                                      child: Text(
                                        'Forget Password?',
                                        style: GoogleFonts.lato(
                                            textStyle:
                                                TextStyle(color: Colors.grey)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30, left: 30, right: 30.0),
                                child: GestureDetector(
                                  onTap: () {
                                    _login();
                                  },
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(24, 44, 88, 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                        child: Text('Login'.toUpperCase(),
                                            style: GoogleFonts.lato(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      PageTransition(
                                          child: Signin(),
                                          type: PageTransitionType.fade));
                                },
                                child: Text(
                                  'New User ? Create account',
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
      ),
    );
  }
}
