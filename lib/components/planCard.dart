import 'package:flutter/material.dart';
import 'package:quiz_app/constants/ui_constants.dart';

class PlanCard extends StatelessWidget {
  // createSubscription(BuildContext context) async {
  //   var auth = await AuthService.getSavedAuth();
  //   var payload = json.encode({
  //     "transaction_id": "123",
  //     "validFrom":
  //         "${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}",
  //     "validTill":
  //         "${(DateTime.now().month + int.parse(plan.duration)) > 12 ? (DateTime.now().year + 1) : DateTime.now().year}-${(DateTime.now().month + int.parse(plan.duration)) > 12 ? (DateTime.now().month + int.parse(plan.duration) - 12) : (DateTime.now().month + int.parse(plan.duration))}-${DateTime.now().day}",
  //     "plan": plan.id,
  //     "count": plan.count + 1,
  //     "subscriptionTaken": true,
  //     "user": auth['id']
  //   });
  //   try {
  //     var subscriptionId =
  //         await SubscriptionService.createSubscription(payload);
  //     if (subscriptionId != '') {
  //       var body = json.encode({"subscription": subscriptionId});
  //       bool isUpdated = await UserService.updateUser(body);
  //       print(isUpdated);
  //     } else {
  //       print("DEBUG");
  //     }
  //   } catch (e) {
  //     print(e);
  //     showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     'Failed to Buy Subscription. Try Again!!!',
  //                     style: Theme.of(context)
  //                         .primaryTextTheme
  //                         .headline6
  //                         .copyWith(
  //                             color: Colors.black,
  //                             letterSpacing: 0.46,
  //                             fontWeight: FontWeight.w500),
  //                   )
  //                 ],
  //               ),
  //               actions: [
  //                 MaterialButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text(
  //                     "Cancel",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       color: Color(0xff25354E),
  //                     ),
  //                   ),
  //                 ),
  //                 MaterialButton(
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(18),
  //                   ),
  //                   color: Color(0xff000000),
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: Text(
  //                     "OK!",
  //                     style: TextStyle(
  //                       fontSize: 18,
  //                       color: Colors.white,
  //                     ),
  //                   ),
  //                 )
  //               ],
  //             ));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 50.0,
      ),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          overflow: Overflow.visible,
          children: [
            Container(
                height: UIConstants.fitToHeight(180, context),
                width: UIConstants.fitToWidth(220, context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    colors: [
                      const Color(0xff0CC1A1),
                      const Color(0xff0D6EC7)
                    ],
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
                          '₹ 100',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .headline4
                              .copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.46,
                                  fontWeight: FontWeight.bold),
                        ),
                        Text('Play all Quiz',
                            style: Theme.of(context)
                                .primaryTextTheme
                                .subtitle1
                                .copyWith(color: Colors.white)),
                        Text('12 months ',
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
            Positioned(
                top: UIConstants.fitToHeight(160, context),
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
                        //await createSubscription(context);
                      },
                      color: Colors.white,
                      child: Text(
                        'Subscribe!',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .button
                            .copyWith(color: Colors.black),
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
