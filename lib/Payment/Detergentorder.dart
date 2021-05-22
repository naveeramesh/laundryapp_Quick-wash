import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_laundary/Pages/Wash.dart';
import 'package:online_laundary/Services/SharedPrefernces.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class DetergentOrders extends StatefulWidget {
  final QueryDocumentSnapshot detergents;
  final int count;

  const DetergentOrders({Key key, this.detergents, this.count})
      : super(key: key);
  @override
  _DetergentOrdersState createState() => _DetergentOrdersState();
}

TextEditingController namecontroller = TextEditingController();
TextEditingController addresscontroller = TextEditingController();
TextEditingController phonenumber = TextEditingController();
TextEditingController amountcontroller = TextEditingController();
int total = 1;
Razorpay _razorpay;

class _DetergentOrdersState extends State<DetergentOrders> {
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
    print(widget.detergents['Title']);
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(SharedPrefernces.sharedPreferences.getString('uid'))
        .set({
      'name of product': widget.detergents['Title'].toString(),
      'amount': widget.detergents['Price'] * widget.count,
      'address': addresscontroller.text.toString(),
      'name of the person': namecontroller.text.toString(),
      'phonenumber': phonenumber.text.toString(),
      'quantity': widget.count,
    
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

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Text('Quick Wash',
                    style: GoogleFonts.quando(
                        textStyle: TextStyle(
                            color: Color.fromRGBO(24, 44, 88, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold))),
                SizedBox(
                  height: 40,
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30.0),
                    child: TextField(
                      controller: addresscontroller,
                      decoration: InputDecoration(
                          hintText: 'ADDRESS : ',
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
                    padding:
                        const EdgeInsets.only(top: 20, left: 30, right: 30.0),
                    child: TextField(
                      controller: phonenumber,
                      decoration: InputDecoration(
                          hintText: 'PH.NO : ',
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 30.0, left: 30, right: 30),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(135, 143, 173, 1),
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Amount:'.toUpperCase(),
                          style: GoogleFonts.josefinSans(
                              fontSize: 10,
                              letterSpacing: 1,
                              color: Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${(widget.detergents['Price'] * widget.count)}',
                          style: GoogleFonts.josefinSans(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: GestureDetector(
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
                    child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(135, 143, 173, 1),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text(
                            'PAYMENT',
                            style: GoogleFonts.josefinSans(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1)),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
