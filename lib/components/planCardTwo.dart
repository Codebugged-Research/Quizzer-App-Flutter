import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';

// ignore: must_be_immutable
class PlanCardTwo extends StatelessWidget {
  String deducted="0";
  PlanCardTwo({this.deducted});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50.0,
      ),
      child: SingleChildScrollView(
        child: Container(
            height: UIConstants.fitToHeight(180, context),
            width: UIConstants.fitToWidth(220, context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                colors: [const Color(0xffFEBC11), const Color(0xffEB372B)],
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Ink(
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  colors: [
                    const Color(0xff0CC1A1),
                    const Color(0xff0D6EC7)
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                     'Be a Member',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline6
                          .copyWith(color: Colors.white),
                    ),
                    Text(
                      '₹ ${(int.parse("60")-int.parse(deducted)).toString()}',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .headline4
                          .copyWith(
                              color: Colors.white,
                              letterSpacing: 0.46,
                              fontWeight: FontWeight.bold),
                    ),
                    Text('Enjoy all Quiz',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .subtitle1
                            .copyWith(color: Colors.white)),
                    Text('3 months',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .caption
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
