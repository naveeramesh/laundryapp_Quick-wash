import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Payment/Order.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Wash extends StatefulWidget {
  @override
  _WashState createState() => _WashState();
}

TextEditingController clothescontroller = new TextEditingController();
String valuechoose;
int quantity = 1;
List _types = [
  'Dry Wash',
  'Bed Spreads',
  'Jackets',
  'White Dresses',
  'Steam Wash',
  'Kids Clothes'
];

class _WashState extends State<Wash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Center(
                    child: Text(
                      'Quick wash',
                      style: GoogleFonts.quando(
                          fontSize: 20,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 40.0, left: 30, right: 30),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color.fromRGBO(135, 143, 173, 1)),
                        borderRadius: BorderRadius.circular(5)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: valuechoose,
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'TYPES OF WASH:',
                            style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    letterSpacing: 1)),
                          ),
                        ),
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            valuechoose = newValue;
                          });
                        },
                        items: _types.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20.0, left: 30, right: 30),
                  child: Container(
                    child: TextField(
                      controller: clothescontroller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(135, 143, 173, 1))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(135, 143, 173, 1))),
                        hintText: 'TYPES OF CLOTHES:',
                        hintStyle: GoogleFonts.josefinSans(
                          textStyle: TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 30.0, right: 30),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'QUANTITY OF CLOTHES:',
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  letterSpacing: 1),
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (quantity > 1) {
                                  quantity = quantity - 1;
                                  print(quantity);
                                }
                              });
                            }),
                        Text(quantity.toString()),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                quantity = quantity + 1;
                                print(quantity);
                              });
                            })
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: valuechoose == null
                      ? SizedBox()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(135, 143, 173, 1)),
                              borderRadius: BorderRadius.circular(5)),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Washing')
                                  .where('Title', isEqualTo: valuechoose)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                    ),
                                  );
                                } else {
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                valuechoose.toString(),
                                                style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        letterSpacing: 1)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '|',
                                                style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                )),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '₹',
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color:
                                                                Colors.black),
                                                  ),
                                                  SizedBox(
                                                    width: 3,
                                                  ),
                                                  Text(
                                                    '${(snapshot.data.docs[index]['Price'] * quantity)}',
                                                    style:
                                                        GoogleFonts.josefinSans(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '|',
                                                style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        letterSpacing: 1)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                clothescontroller.text
                                                    .toString(),
                                                style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                '|',
                                                style: GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        letterSpacing: 1)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                quantity.toString(),
                                                style: GoogleFonts.quicksand(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                        letterSpacing: 1)),
                                              ),
                                            ],
                                          ),
                                        );
                                      });
                                }
                              }),
                        ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    valuechoose != null &&
                            quantity != null &&
                            clothescontroller.text.isNotEmpty
                        ? _upload()
                        : Toast.show("Please the given items", context,
                            backgroundColor: Color.fromRGBO(24, 44, 88, 1),
                            duration: Toast.LENGTH_LONG,
                            gravity: Toast.BOTTOM);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(135, 143, 173, 1),
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                          child: Text('BOOK',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ))),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ));
  }

  void _upload() async {
    Navigator.push(
        context,
        PageTransition(
            child: Order(
              wash: valuechoose,
              quantity: quantity.toString(),
              clothes: clothescontroller.toString(),
            ),
            type: PageTransitionType.fade));
    // FirebaseFirestore.instance
    //     .collection('Orders')
    //     .doc(SharedPrefernces.sharedPreferences.getString('uid'))
    //     .set({
    //   'type of clothes': clothescontroller.text.toString(),
    //   'quantity': quantity,
    //   'types of wash': valuechoose,
    // }).whenComplete(() {

    // });
  }
}
