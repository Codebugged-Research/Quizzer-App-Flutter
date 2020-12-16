import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Razorpay razorpay;
  TextEditingController amount = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  void openCheckOut() {
    var options = {
      "key": "rzp_test_sOzJvizxWHgZgS",
      "amount": double.parse(amount.text.trim())*100,
      "name": "Quizzer App",
      "description": "Pay to be a member",
      "prefill": {"contact": "9874948947", "email": "sayannath235@gmail.com"},
      "external": {
        "wallet": ["paytm"],
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  void handlePaymentSuccess() {
    print("Payment Done");
  }

  void handlePaymentError() {
    print("Error");
  }

  void handleExternalWallet() {
    print("Yo");
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RazorPay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            TextField(
              controller: amount,
              decoration: InputDecoration(hintText: 'Pay'),
            ),
            SizedBox(height: 20),
            RaisedButton(
              onPressed: () {
                openCheckOut();
              },
              child: Text(
                'Pay',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
