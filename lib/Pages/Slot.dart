import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:provider/provider.dart';
import 'package:online_laundary/Services/Get.dart';

class Slot extends StatefulWidget {
  @override
  _SlotState createState() => _SlotState();
}

class _SlotState extends State<Slot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(135, 143, 173, 1),
        title: Text('TIME SLOT',
            style: GoogleFonts.josefinSans(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                textStyle: TextStyle(letterSpacing: 2, color: Colors.white))),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 400,
            child: Column(
              children: [
                Table(
                  children: [
                    TableRow(children: [
                      Column(children: [
                        Text('SERVICE TYPE',
                            style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(24, 44, 88, 1),
                                    fontWeight: FontWeight.bold)))
                      ]),
                      Column(children: [
                        Text('TIME',
                            style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(24, 44, 88, 1),
                                    fontWeight: FontWeight.bold)))
                      ])
                    ]),
                  ],
                ),
                Container(
                  height: 300,
                  child: FutureBuilder(
                      future: Provider.of<Demo>(context, listen: false)
                          .getData('Timeslot'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.blue),
                            ),
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Table(
                                  border: TableBorder(
                                      verticalInside: BorderSide(
                                          width: 1,
                                          color:
                                              Color.fromRGBO(135, 143, 173, 1),
                                          style: BorderStyle.solid)),
                                  children: [
                                    TableRow(children: [
                                      Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text(
                                              snapshot.data[index]
                                                  .data()['Title']
                                                  .toUpperCase(),
                                              style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          135, 143, 173, 1),
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        )
                                      ]),
                                      Column(children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Text(
                                              snapshot.data[index]
                                                  .data()['Time']
                                                  .toUpperCase(),
                                              style: GoogleFonts.josefinSans(
                                                  textStyle: TextStyle(
                                                      color: Color.fromRGBO(
                                                          135, 143, 173, 1),
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        )
                                      ])
                                    ]),
                                  ],
                                );
                              });
                        }
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
