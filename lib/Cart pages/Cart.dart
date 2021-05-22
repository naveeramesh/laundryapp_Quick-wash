import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(135, 143, 173, 1),
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(135, 143, 173, 1),
          title: Text('CART ITEMS',
              style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      letterSpacing: 2,
                      color: Colors.white))),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(SharedPrefernces.sharedPreferences.getString('uid'))
                .collection('Cart')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null && snapshot.data.docs.length != 0) {
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 100,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data.docs[index]['Image']),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]['Title'],
                                      style: GoogleFonts.josefinSans(
                                          textStyle: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              letterSpacing: 1,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rupeeSign,
                                          size: 10,
                                        ),
                                        Text(
                                          snapshot.data.docs[index]['Price']
                                              .toString(),
                                          style: GoogleFonts.josefinSans(
                                              textStyle: TextStyle(
                                                  color: Colors.black,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Quantity:',
                                          style: GoogleFonts.josefinSans(
                                            textStyle: TextStyle(
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    24, 44, 88, 1)),
                                          ),
                                        ),
                                        Text(snapshot
                                            .data.docs[index]['Quantity']
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.delete,
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection('Users')
                                        .doc(SharedPrefernces.sharedPreferences
                                            .getString('uid'))
                                        .collection('Cart')
                                        .doc(snapshot.data.docs[index]
                                            ['ProductId'])
                                        .delete();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            )
                          ]),
                        ),
                      );
                    });
              } else {
                return Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    Container(
                      height: 300,
                      width: 500,
                      child: Lottie.network(
                          'https://assets7.lottiefiles.com/temp/lf20_Celp8h.json'),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                );
              }
            }));
  }
}
