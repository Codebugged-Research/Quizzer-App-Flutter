import 'package:flutter/material.dart';

class Item3 extends StatelessWidget {
  const Item3({Key key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Image.asset('assets/images/ads/3.png', fit: BoxFit.fitWidth)
    );
  }
}