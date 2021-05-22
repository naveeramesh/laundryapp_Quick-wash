import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Cart%20pages/Cart.dart';
import 'package:online_laundary/Payment/Detergentorder.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Products extends StatefulWidget {
  final QueryDocumentSnapshot snapshots;

  const Products({
    Key key,
    this.snapshots,
  }) : super(key: key);
  @override
  _ProductsState createState() => _ProductsState();
}



class _ProductsState extends State<Products> {
  int number = 1;
  bool iscart = false;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefernces.sharedPreferences.getString("uid"))
        .collection("Cart")
        .doc(widget.snapshots['Productid'])
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          iscart = true;
        });
      } else {
        iscart = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Color.fromRGBO(135, 143, 173, 1),
        statusBarIconBrightness: Brightness.light));
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(135, 143, 173, 1),
        title: Text(widget.snapshots['Title'].toUpperCase(),
            style: GoogleFonts.josefinSans(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(letterSpacing: 2, color: Colors.white))),
        actions: [
          IconButton(
              icon: Icon(Icons.shopping_bag_outlined),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: Cart(), type: PageTransitionType.rightToLeft));
              })
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.032,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Center(
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.snapshots['Image1']))),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.snapshots['Title'].toUpperCase(),
                      style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(24, 44, 88, 1),
                            letterSpacing: 1,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        FontAwesomeIcons.rupeeSign,
                        color: Color.fromRGBO(24, 44, 88, 1),
                        size: 15,
                      ),
                      Text(widget.snapshots['Price'].toString(),
                          style: GoogleFonts.lato(
                              color: Color.fromRGBO(24, 44, 88, 1),
                              fontSize: 20,
                              letterSpacing: 1)),
                    ],
                  ),
                ),
                Container(
                  height: 120,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 20, right: 30),
                    child: Text(widget.snapshots['Description'],
                        style: GoogleFonts.josefinSans(
                            color: Color.fromRGBO(24, 44, 88, 1),
                            fontSize: 20,
                            letterSpacing: 1)),
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Quantity:',
                        style: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              color: Color.fromRGBO(24, 44, 88, 1)),
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (number > 1) {
                              number = number - 1;
                              print(number);
                            }
                          });
                        }),
                    Text(number.toString()),
                    IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            number = number + 1;
                            print(number);
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: DetergentOrders(
                                detergents: widget.snapshots,
                                count: number,
                              ),
                              type: PageTransitionType.fade));
                    },
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(135, 143, 173, 1),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            'BUY NOW',
                            style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: DetergentOrders(
                                detergents: widget.snapshots,
                                count: number,
                              ),
                              type: PageTransitionType.fade));
                    },
                    child: GestureDetector(
                      onTap: () {
                        iscart
                            ? Toast.show("Already Added", context,
                                backgroundColor: Color.fromRGBO(24, 44, 88, 1),
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM)
                            : FirebaseFirestore.instance
                                .collection('Users')
                                .doc(SharedPrefernces.sharedPreferences
                                    .getString('uid'))
                                .collection('Cart')
                                .doc(widget.snapshots['Productid'])
                                .set({
                                'Image': widget.snapshots['Image1'],
                                'Title': widget.snapshots['Title'],
                                'Price': widget.snapshots['Price'],
                                'Quantity': number,
                                'ProductId': widget.snapshots['Productid']
                              }).whenComplete(() {
                                Toast.show("Check cart", context,
                                    backgroundColor:
                                        Color.fromRGBO(24, 44, 88, 1),
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              });
                      },
                      child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(135, 143, 173, 1),
                              borderRadius: BorderRadius.circular(6)),
                          child: Center(
                            child: Text(
                              'ADD TO CART',
                              style: GoogleFonts.josefinSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1)),
                            ),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
