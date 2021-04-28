import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:paytm/paytm.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/subscriptionService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Home/homebackup.dart';
import 'package:quiz_app/views/landingScreen.dart';

class PayTmScreen extends StatefulWidget {
  PayTmScreen({this.month, this.amount, this.offerId, this.orderId});
  final String orderId;
  final String amount;
  final String offerId;
  final int month;

  @override
  _PayTmScreenState createState() => _PayTmScreenState();
}

class _PayTmScreenState extends State<PayTmScreen> {
  // ignore: non_constant_identifier_names

  bool loading = false;
  bool testing = false;
  User user;

  @override
  void initState() {
    super.initState();
    generateTxnToken();
  }

  createSubscriptionForUser(int month) async {
    print("//////////////////////////");
    var payload = json.encode({
      "user": user.id,
      "validFrom":
          "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
      "validTill":
          "${(DateTime.now().month + month) > 12 ? (DateTime.now().year + 1) : DateTime.now().year}-${(DateTime.now().month + month) > 12 ? (DateTime.now().month + month - 12) : (DateTime.now().month + month)}-${DateTime.now().day}",
      "offerId": "${widget.offerId}"
    });
    print(payload);
    String id = await SubscriptionService.createSubscription(payload);
    print("---------------------------" + id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: loading ? CircularProgressIndicator() : Container(),
    ));
  }

  void generateTxnToken() async {
    user = await UserService.getUser();
    setState(() {
      loading = true;
    });
    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = (testing
            ? 'https://securegw-stage.paytm.in'
            : 'https://securegw.paytm.in') +
        '/theia/paytmCallback?ORDER_ID=' +
        orderId;

    var url = 'http://139.59.9.205/paytm/genTxnToken';

    var body = json.encode({
      "mid": "FXLFkw28594845162173",
      "key_secret": "wYC87iQD17gyZ5IB",
      "website": "DEFAULT",
      "orderId": orderId,
      "amount": widget.amount,
      "callbackUrl": (testing
              ? 'https://securegw-stage.paytm.in'
              : 'https://securegw.paytm.in') +
          '/theia/paytmCallback?ORDER_ID=' +
          orderId,
      "custId": orderId,
      "testing": testing ? 0 : 1
    });

    try {
      final response = await http.post(
        url,
        body: body,
        headers: {'Content-type': "application/json"},
      );
      print("Response is");
      print(response.body);
      String txnToken = response.body;
      var paytmResponse = await Paytm.payWithPaytm("FXLFkw28594845162173", orderId,
          txnToken, widget.amount.toString(), callBackUrl, testing);
      print(paytmResponse["RESPMSG"]);
      print(paytmResponse["error"]);
      if (!paytmResponse['error']) {
        createSubscriptionForUser(widget.month);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PaymentSuccessfulScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => PaymentFailedScreen()));
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}

class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "OOPS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Payment was not successful, Please try again Later!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => LandingScreen(selectedIndex: 0,)),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PaymentSuccessfulScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Great!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Thank you for making the payment!",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 50,
                ),
                MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40)),
                    color: Colors.black,
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () async {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => LandingScreen(selectedIndex: 0,)),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
