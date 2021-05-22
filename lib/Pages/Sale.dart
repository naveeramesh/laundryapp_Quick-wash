import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_laundary/Pages/Product.dart';

import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:online_laundary/Services/Get.dart';

class Sale extends StatefulWidget {
  @override
  _SaleState createState() => _SaleState();
}

class _SaleState extends State<Sale> {
  MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Detergents'),
          backgroundColor: Color.fromRGBO(39, 170, 226, 1),
        ),
        body: Container(
          height: queryData.size.height * 1,
          child: FutureBuilder(
              future: Provider.of<Demo>(context, listen: false)
                  .getData('Detergents'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  );
                } else {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child: (Products()),
                                        type: PageTransitionType.fade));
                              },
                              child: Container(
                                child: Row(children: [
                                  Container(
                                    height: 150,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(snapshot
                                                .data[index]
                                                .data()['Image']))),
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Text(
                                          snapshot.data[index]
                                              .data()['Title']
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 40.0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              FontAwesomeIcons.rupeeSign,
                                              size: 10,
                                            ),
                                            Text(
                                              snapshot.data[index]
                                                  .data()['Price'],
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            ),
                          ],
                        );
                      });
                }
              }),
        ),
      ),
    );
  }
}
