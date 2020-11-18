import 'package:flutter/material.dart';

class Item4 extends StatelessWidget {
  const Item4({Key key}) : super(key: key);
@override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Data",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold
            )
          ),
          Text(
            "Data",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      ),
    );
  }
}