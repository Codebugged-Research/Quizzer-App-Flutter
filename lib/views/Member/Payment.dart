import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/subscriptionService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Member/TransactrionScreen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../landingScreen.dart';

class Payment extends StatefulWidget {
  final String orderId;
  final String amount;
  final String offerId;
  final int month;
  final User user;

  const Payment(
      {this.amount, this.month, this.offerId, this.orderId, this.user});

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String selectedUrl;
  double progress = 0;
  bool isLoading = true;
  String paymentRequestId;
  var options;

  @override
  void initState() {
    super.initState();
    createRequest();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
            appBar: AppBar(),
            body: Container(
              child: WebView(
                initialUrl: selectedUrl,
                onProgress: (progress) => setState(() {
                  this.progress = progress / 100;
                }),
                onPageFinished: (ss) {
                  if (ss.contains('https://quizaddaplus.tk/')) {
                    Uri uri = Uri.parse(ss);
                    print(uri.queryParameters['payment_id']);
                    paymentRequestId = uri.queryParameters['payment_id'];
                    _checkPaymentStatus(paymentRequestId);
                  } else {
                    print("onupdate mounted else");
                  }
                },
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          );
  }

  _checkPaymentStatus(String id) async {
    var response = await http.get(
        Uri.parse("https://www.instamojo.com/api/1.1/payments/$id/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "db9e70a71b51a731cc18e9ac68255de7",
          "X-Auth-Token": "5d0aaa7a7e6d52799fabfb1e21660ed8"
        });
    var realResponse = json.decode(response.body);
    print(realResponse);
    if (realResponse['success'] == true) {
      if (realResponse["payment"]['status'] == 'Credit') {
        var payload = json.encode({
          "user": widget.user.id,
          "validFrom":
              "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
          "validTill":
              "${(DateTime.now().month + widget.month) > 12 ? (DateTime.now().year + 1) : DateTime.now().year}-${(DateTime.now().month + widget.month) > 12 ? (DateTime.now().month + widget.month - 12) : (DateTime.now().month + widget.month)}-${DateTime.now().day}",
          "offerId": "${widget.offerId}"
        });
        var id = await SubscriptionService.createSubscription(payload);
        if (id) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentSuccessfulScreen(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentFailedScreen(),
            ),
          );
        }
      }
    } else {
      Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => PaymentFailedScreen(),
            ),
          );
    }
  }

  Future createRequest() async {
    Map<String, String> body = {
      "amount": widget.amount,
      "purpose": "subscription ${widget.user.id}",
      "buyer_name": widget.user.name,
      "email": widget.user.email,
      "phone": widget.user.phone,
      "allow_repeated_payments": "true",
      "send_email": "true",
      "send_sms": "true",
      "redirect_url": "https://quizaddaplus.tk/",
    };

    var resp = await http.post(
        Uri.parse("https://www.instamojo.com/api/1.1/payment-requests/"),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Api-Key": "db9e70a71b51a731cc18e9ac68255de7",
          "X-Auth-Token": "5d0aaa7a7e6d52799fabfb1e21660ed8"
        },
        body: body);
    if (json.decode(resp.body)['success'] == true) {
      setState(() {
        isLoading = false;
        selectedUrl =
            json.decode(resp.body)["payment_request"]['longurl'].toString() +
                "?embed=form";
      });
    }
  }
}
