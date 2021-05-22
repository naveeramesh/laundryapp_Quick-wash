import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Payment/Order.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class Iron extends StatefulWidget {
  @override
  _IronState createState() => _IronState();
}

TextEditingController timecontroller = new TextEditingController();
String valueavailable;
int quantity = 1;
String values;
String timeslot;
String items;
List _list = [
  'Shirt',
  'Saree and blouse',
  'Pants',
  'Chudi set',
  'Crop tops',
  'Uniforms'
];

class _IronState extends State<Iron> {
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
            child: Column(
              children: [
                Container(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 20),
                  child: Center(
                    child: Text(
                      'Quick Wash',
                      style: GoogleFonts.quando(
                          fontSize: 20,
                          textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                )),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'TYPES OF CLOTHES:',
                            style: GoogleFonts.josefinSans(
                              textStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        value: valueavailable,
                        isExpanded: true,
                        onChanged: (newValue) {
                          setState(() {
                            valueavailable = newValue;
                            items = newValue;
                            print(newValue);
                            print(items);
                          });
                        },
                        items: _list.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
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
                              textStyle:
                                  TextStyle(fontSize: 10, color: Colors.grey),
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
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: Container(
                    child: TextField(
                      controller: timecontroller,
                      onChanged: (val) {
                        setState(() {
                          timeslot = val;
                        });
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(135, 143, 173, 1))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(135, 143, 173, 1))),
                          hintText: 'TIME:',
                          hintStyle: GoogleFonts.josefinSans(
                            textStyle:
                                TextStyle(fontSize: 10, color: Colors.grey),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: items == null
                      ? SizedBox()
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color.fromRGBO(135, 143, 173, 1)),
                              borderRadius: BorderRadius.circular(5)),
                          child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Iron')
                                  .where('Title', isEqualTo: items)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.blue)),
                                  );
                                } else {
                                  return ListView.builder(
                                      itemCount: snapshot.data.docs.length,
                                      itemBuilder: (builder, int index) {
                                        return Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Text(items.toString(),
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                        color: Colors.black),
                                                  )),
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
                                            Row(
                                              children: [
                                                Text(
                                                  '₹',
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          color: Colors.black),
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  '${(snapshot.data.docs[index]['Price'] * quantity)}',
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(quantity.toString(),
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                    textStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10.0),
                                              child: Text(
                                                  timecontroller.text
                                                      .toString(),
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                    fontWeight: FontWeight.bold,
                                                    textStyle: TextStyle(
                                                        color: Colors.black),
                                                  )),
                                            ),
                                          ],
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
                    items != null &&
                            quantity != null &&
                            timecontroller.text.isNotEmpty
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
                              style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void _upload() async {
    Navigator.push(
        context,
        PageTransition(
            child: Order(
              wash: items,
              quantity: quantity.toString(),
              time: timecontroller.text,
            ),
            type: PageTransitionType.fade));
  }
}
