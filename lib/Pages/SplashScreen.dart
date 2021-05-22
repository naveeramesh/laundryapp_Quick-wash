import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Pages/HomeScreen.dart';
import 'package:online_laundary/Pages/Login.dart';
import 'package:online_laundary/Pages/Signin.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 400,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/illustration.png'))),
          ),
          Text('Quick Wash !'.toUpperCase(),
              style: GoogleFonts.quando(
                textStyle: TextStyle(
                    color: Color.fromRGBO(24, 44, 88, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          SizedBox(
            height: 10,
          ),
          Text('Live a simple life by using our app !'.toUpperCase(),
              style: GoogleFonts.quando(
                textStyle: TextStyle(
                  color: Color.fromRGBO(24, 44, 88, 1),
                ),
              )),
          SizedBox(
            height: 250,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(135, 143, 173, 1),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: Signin(),
                                    type: PageTransitionType.fade));
                          },
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(24, 44, 88, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('Register'.toUpperCase(),
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    child: SharedPrefernces.sharedPreferences
                                                .getString('email') ==
                                            null
                                        ? Login()
                                        : HomeScreen(),
                                    type: PageTransitionType.fade));
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
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            ),
          )
        ],
      ),
    );
  }
}
