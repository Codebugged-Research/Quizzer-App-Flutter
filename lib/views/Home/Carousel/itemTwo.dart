import 'package:flutter/material.dart';

class Item2 extends StatelessWidget {
  const Item2({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Image.asset('assets/images/ads/2.png', fit: BoxFit.fitWidth));
  }
}
