import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/subscriptionService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/landingScreen.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  final String orderId;
  final String amount;
  RazorPayScreen({this.orderId, this.amount});

  @override
  _RazorPayScreenState createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  Razorpay _razorpay = Razorpay();
  User user;
  var options;
  Future payData() async {
    try {
      _razorpay.open(options);
    } catch (e) {
      print("errror occured here is ......................./:$e");
    }

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  createSubscriptionForUser() async {
    var payload = json.encode({
      "user": user.id,
      "validFrom":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "validTill":
          "${(DateTime.now().month + 1) > 12 ? (DateTime.now().year + 1) : DateTime.now().year}-${(DateTime.now().month + 1) > 12 ? (DateTime.now().month + 1 - 12) : (DateTime.now().month + 1)}-${DateTime.now().day}",
    });
    String id = await SubscriptionService.createSubscription(payload);
    // Scaffold.of(context).showSnackBar(SnackBar(
    //   content: Text('Subscription Ordered'),
    // ));
    print("---------------------------" + id);
  }

  final scaffkey = new GlobalKey<ScaffoldState>();
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    print("payment has succedded");
    // scaffkey.currentState.showSnackBar(SnackBar(
    //   content: Text('Success'),
    // ));
    createSubscriptionForUser();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LandingScreen(
              selectedIndex: 0,
            )));
    _razorpay.clear();
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("payment has error00000000000000000000000000000000000000");
    // Do something when payment fails

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LandingScreen(
              selectedIndex: 0,
            )));

    _razorpay.clear();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("payment has externalWallet33333333333333333333333333");

    _razorpay.clear();
    // Do something when an external wallet is selected
  }

  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    loadDataScreen();
  }

  loadDataScreen() async {
    setState(() {
      isLoading = true;
    });
    user = await UserService.getUser();
    setState(() {
      options = {
        'key': "rzp_test_YGmmPUQEmTBUaA",
        'amount': int.parse(widget.amount),
        'name': 'Quiz Adda',
        'order_id': widget.orderId,
        'currency': "INR",
        'theme.color': "#528ff0",
        'buttontext': "Pay",
        'description': 'Pay to be a Member',
        "prefill": {"contact": "${user.phone}", "email": "${user.email}"},
      };
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : FutureBuilder(
              future: payData(),
              builder: (context, snapshot) {
                return Container(
                  child: Center(
                    child: Text(
                      "Starting Transaction...", //can do a setstate for payment error
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
