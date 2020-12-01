import 'package:flutter/material.dart';

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Image.asset('assets/images/ads/4.png', fit: BoxFit.fitWidth)
    );
  }
}