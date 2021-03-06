import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/components/planCard.dart';
import 'package:quiz_app/components/planCardTwo.dart';
import 'package:quiz_app/constants/ui_constants.dart';
import 'package:quiz_app/models/Offer.dart';
import 'package:quiz_app/models/User.dart';
import 'package:quiz_app/services/offerService.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:quiz_app/views/Member/Payment.dart';
// import 'package:quiz_app/views/Member/paytm.dart';
import 'package:quiz_app/views/landingScreen.dart';

class MemberScreen extends StatefulWidget {
  @override
  _MemberScreenState createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  bool isLoading = false;
  User user;
  List<Offer> offers = [];
  List<DropdownMenuItem> offerItems = [];
  Offer offer;
  String orderId;
  var offerId;
  var options;
  var _selectedItem;
  String deductionAmount = "0";

  @override
  void initState() {
    super.initState();
    loadDataForScreen();
  }

  bool subscribed = false;
  loadDataForScreen() async {
    setState(() {
      isLoading = true;
    });
    user = await UserService.getUser();
    offers = await OfferService.getAllOffers();
    offers.forEach((element) {
      offerItems.add(DropdownMenuItem(
        value: element,
        child: Text(element.name),
      ));
    });
    setState(() {
      offerId = offers[0].id;
      _selectedItem = (offers[0]);
      deductionAmount = offers[0].amount;
      isLoading = false;
    });
    if (user.subscription != null) {
      if (user.subscription.validTill.difference(DateTime.now()).inDays >= 0) {
        setState(() {
          subscribed = true;
        });
      }
      showDialogScreen();
    }
  }


  final scaffkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        // For Android.
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        key: scaffkey,
        body: !isLoading
            ? SingleChildScrollView(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: UIConstants.fitToHeight(260, context),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: UIConstants.fitToHeight(32, context)),
                          Text(
                            'Subscription',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .primaryTextTheme
                                .headline4
                                .copyWith(color: Colors.white),
                          ),
                          SizedBox(
                              height: UIConstants.fitToHeight(16, context)),
                          Text(
                            'Select Offers!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                              height: UIConstants.fitToHeight(16, context)),
                          offerItems != null
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isDense: true,
                                          hint: Text(
                                            'Select Offers!',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          iconEnabledColor: Colors.black,
                                          value: _selectedItem,
                                          items: offerItems,
                                          onChanged: (value) async {
                                            setState(() {
                                              _selectedItem = (value);
                                              offerId = value.id;
                                              deductionAmount = value.amount;
                                            });
                                          }),
                                    ),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: UIConstants.fitToHeight(16, context),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              PlanCard(deducted: deductionAmount.toString()),
                              buyWidgetOne(context),
                            ],
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              PlanCardTwo(deducted: deductionAmount.toString()),
                              buyWidgetTwo(context),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Widget buyWidgetOne(context) {
    return Positioned(
      top: UIConstants.fitToHeight(160, context),
      left: UIConstants.fitToWidth(55, context),
      right: UIConstants.fitToWidth(55, context),
      child: Container(
          height: UIConstants.fitToHeight(40, context),
          width: UIConstants.fitToWidth(110, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ]),
          child: MaterialButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            orderId: orderId,
                            amount: (30 -
                                    (int.parse("${deductionAmount.toString()}") ))
                                .toString(),
                            offerId: "$offerId", month: 1,
                        user: user,
                          )));
            },
            color: Colors.white,
            child: Text(
              'Subscribe!',
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(color: Colors.black),
            ),
          )),
    );
  }

  Widget buyWidgetTwo(context) {
    return Positioned(
      top: UIConstants.fitToHeight(160, context),
      left: UIConstants.fitToWidth(55, context),
      right: UIConstants.fitToWidth(55, context),
      child: Container(
          height: UIConstants.fitToHeight(40, context),
          width: UIConstants.fitToWidth(110, context),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
                BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 2,
                  color: Color.fromRGBO(0, 0, 0, 0.15),
                ),
              ]),
          child: MaterialButton(
            onPressed: () async {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Payment(
                            orderId: orderId,
                            amount: (45 -
                                    (int.parse("${deductionAmount.toString()}")))
                                .toString(),
                            offerId: "$offerId", month: 3,
                        user: user,
                          )));
            },
            color: Colors.white,
            child: Text(
              'Subscribe!',
              style: Theme.of(context)
                  .primaryTextTheme
                  .button
                  .copyWith(color: Colors.black),
            ),
          )),
    );
  }

  showDialogScreen() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            // ignore: missing_return
            onWillPop: () {},
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text('You are already subscribed!!!',
                  style: GoogleFonts.sourceSansPro(
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold))),
              actions: [
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  color: Color(0xff000000),
                  onPressed: () async {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) =>
                                LandingScreen(selectedIndex: 0)),
                        (Route<dynamic> route) => false);
                  },
                  child: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )));
  }
}
