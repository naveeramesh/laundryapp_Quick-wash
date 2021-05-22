import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Cart%20pages/Cart.dart';
import 'package:online_laundary/Pages/Product.dart';
import 'package:online_laundary/Pages/Wash.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:page_transition/page_transition.dart';
import 'package:online_laundary/Pages/Slot.dart';
import 'package:online_laundary/Pages/Iron.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

Position _currentPosition;
String _currentAddress;
String name;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(135, 143, 173, 1),
        statusBarIconBrightness: Brightness.light));
    name = SharedPrefernces.sharedPreferences.getString("username");
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 32,
              ),
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 143, 173, 1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    )),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Q'.toUpperCase(),
                          style: GoogleFonts.quando(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 40,
                                  letterSpacing: 1)),
                        ),
                        Text(
                          'uick Wash',
                          style: GoogleFonts.quando(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                  letterSpacing: 1)),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    IconButton(
                        icon: Icon(Icons.shopping_bag_outlined,color: Colors.white,),
                        onPressed: () {
                          Navigator.push(context, PageTransition(child: Cart(), type:PageTransitionType.rightToLeft));
                        }),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: Wash(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                'Book Washing',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: Iron(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                'Book Ironing',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: Slot(),
                                        type: PageTransitionType.fade));
                              },
                              child: Text(
                                'Check Time Slot',
                                style: TextStyle(color: Colors.black),
                              ),
                            )
                          ],
                        )),
                      ],
                      child: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20.0),
                    child: Row(
                      children: [
                        Text('Hey',
                            style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${(name) != null ? name : ' '}',
                            style: GoogleFonts.josefinSans(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 33)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '!',
                          style: GoogleFonts.quando(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: Text(
                      'What Service are you expecting today ?',
                      style: GoogleFonts.josefinSans(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 200.0,
                    child: Carousel(
                      boxFit: BoxFit.contain,
                      images: [
                        ExactAssetImage('assets/images/1.jpg'),
                        ExactAssetImage('assets/images/2.jpg'),
                        ExactAssetImage('assets/images/3.jpg'),
                      ],
                      showIndicator: false,
                      borderRadius: false,
                      moveIndicatorFromBottom: 180.0,
                      noRadiusForIndicator: true,
                      overlayShadow: true,
                      overlayShadowColors: Colors.grey[100],
                      overlayShadowSize: 0.7,
                    )),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Washing Clothes'.toUpperCase(),
                      style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 143, 173, 1).withOpacity(0.3)),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Washing')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blue)));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (builder, int index) {
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: Wash(),
                                                  type: PageTransitionType
                                                      .rightToLeft));
                                        },
                                        child: Container(
                                          height: 130,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data.docs[index]['Image']),
                                                fit: BoxFit.contain,
                                              )),
                                        ),
                                      )),
                                  Text(
                                    snapshot.data.docs[index]['Title']
                                        .toUpperCase(),
                                    style: GoogleFonts.josefinSans(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.rupeeSign,
                                        color: Colors.black,
                                        size: 10,
                                      ),
                                      Text(
                                        snapshot.data.docs[index]['Price']
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      }
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text('Your Location'.toUpperCase(),
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.grey[200],
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.location_on,
                                color: Color.fromRGBO(135, 143, 173, 1),
                              ),
                              onPressed: () {}),
                          _currentAddress != null
                              ? Text(_currentAddress,
                                  style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1)))
                              : GestureDetector(
                                  onTap: () {
                                    _getCurrentLocation();
                                  },
                                  child: Container(
                                    child: Text('Add Location',
                                        style: GoogleFonts.josefinSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        )),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Ironing Clothes'.toUpperCase(),
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1)),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Iron(), type: PageTransitionType.rightToLeft));
                },
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(135, 143, 173, 1).withOpacity(0.3)),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Iron')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.blue)));
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (builder, int index) {
                                return Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          height: 140,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data.docs[index]['Image']),
                                                fit: BoxFit.contain,
                                              )),
                                        )),
                                    Row(
                                      children: [
                                        Text(
                                          snapshot.data.docs[index]['Title']
                                              .toUpperCase(),
                                          style: GoogleFonts.josefinSans(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rupeeSign,
                                          color: Colors.black,
                                          size: 10,
                                        ),
                                        Text(
                                          snapshot.data.docs[index]['Price']
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                  ],
                                );
                              });
                        }
                      }),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Text(
                      'Products'.toUpperCase(),
                      style: GoogleFonts.lato(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 143, 173, 1).withOpacity(0.3)),
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.blue)));
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.docs.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (builder, int index) {
                              return Column(
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  child: Products(
                                                      snapshots: snapshot
                                                          .data.docs[index]),
                                                  type: PageTransitionType
                                                      .rightToLeft));
                                        },
                                        child: Container(
                                          height: 140,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              image: DecorationImage(
                                                image: NetworkImage(snapshot
                                                    .data.docs[index]['Image']),
                                                fit: BoxFit.contain,
                                              )),
                                        ),
                                      )),
                                  Row(
                                    children: [
                                      Text(
                                        snapshot.data.docs[index]['Title']
                                            .toUpperCase(),
                                        style: GoogleFonts.josefinSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            });
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.name},${place.postalCode},${place.country}";
        print(_currentAddress);
      });
    } catch (e) {
      print(e);
    }
  }
}
