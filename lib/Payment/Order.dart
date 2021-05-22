import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Order extends StatefulWidget {
  final String wash, quantity, time, clothes;

  const Order({
    Key key,
    this.wash,
    this.quantity,
    this.time,
    this.clothes,
  }) : super(key: key);
  @override
  _OrderState createState() => _OrderState();
}

TextEditingController namecontroller = TextEditingController();
TextEditingController addresscontroller = TextEditingController();
TextEditingController phonenumber = TextEditingController();
TextEditingController amountcontroller = TextEditingController();
int total = 1;
Razorpay _razorpay;

class _OrderState extends State<Order> {
  @override
  void initState() {
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckUp() async {
    var options = {
      'key': 'rzp_test_9h2E08DD1F93bC',
      'amount': total * 100,
      'name': 'LAUNDRY',
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    FirebaseFirestore.instance
        .collection('Wash Iron Order')
        .doc(SharedPrefernces.sharedPreferences.getString('uid'))
        .set({
      'types of wash': widget.wash.toString(),
      'quantity': widget.quantity,
      'time': widget.time.toString(),
      'types of clothes': widget.clothes.toString(),
      'Address': addresscontroller.text.toString(),
      'Name': namecontroller.text.toString(),
      'Phone Number': phonenumber.text.toString(),
    }).whenComplete(() {
      Toast.show('Order placed successfully', context,
          backgroundColor: Color.fromRGBO(135, 143, 173, 1),
          duration: Toast.LENGTH_LONG,
          gravity: Toast.BOTTOM);
    });
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Toast.show(
        'Error' + response.code.toString() + '-' + response.message, context,
        backgroundColor: Colors.blue,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Toast.show('ExternalWallet' + response.walletName, context,
        backgroundColor: Colors.blue,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(135, 143, 173, 1),
        title: Text(
          'PAYMENT',
          style: GoogleFonts.josefinSans(
              textStyle: TextStyle(
            color: Colors.white,
            letterSpacing: 1,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 50,
          ),
          Text('Order Details',
              style: GoogleFonts.quando(
                textStyle: TextStyle(
                    letterSpacing: 1,
                    fontSize: 20,
                    color: Color.fromRGBO(24, 44, 88, 1),
                    fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 30,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30.0),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                    hintText: 'NAME : ',
                    hintStyle: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      letterSpacing: 1,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1)))),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30.0),
              child: TextField(
                controller: addresscontroller,
                decoration: InputDecoration(
                    hintText: 'ADDRESS: ',
                    hintStyle: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      letterSpacing: 1,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1)))),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30.0),
              child: TextField(
                controller: phonenumber,
                decoration: InputDecoration(
                    hintText: 'PH.NO : ',
                    hintStyle: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      letterSpacing: 1,
                    )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1)))),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30.0),
              child: TextField(
                controller: amountcontroller,
                decoration: InputDecoration(
                    hintText: 'AMOUNT:',
                    hintStyle: GoogleFonts.josefinSans(
                        fontSize: 10,
                        textStyle: TextStyle(
                          color: Colors.grey,
                          letterSpacing: 1,
                        )),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(135, 143, 173, 1)))),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
          ),
          GestureDetector(
            onTap: () {
              namecontroller.text.isEmpty &&
                      addresscontroller.text.isEmpty &&
                      phonenumber.text.isEmpty
                  ? Toast.show('Please fill the above items', context,
                      backgroundColor: Color.fromRGBO(135, 143, 173, 1),
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM)
                  : openCheckUp();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(135, 143, 173, 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    'PAY',
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
