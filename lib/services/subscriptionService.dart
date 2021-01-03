import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Subscription.dart';
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/userService.dart';

class SubscriptionService extends AuthService {
  // ignore: missing_return
  static Future<String> createSubscription(var payload) async {
     http.Response response = await AuthService. makeAuthenticatedRequest(
        AuthService.BASE_URI + 'subscription/create',
        method: 'POST',
        body: payload);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      Subscription subscription = Subscription.fromJson(responseMap);
      if(subscription.id!=null){
       bool updated =  await UserService.updateUser(jsonEncode({"subscription": subscription.id}));
       if(updated){
         print("updated");
       }else{
         print("debug update user in subscription");
       }
      }
    } else {
      print("debug create subscription");
      return '';
    }
  }

  // ignore: missing_return
  static Future<List<Subscription>> getSubscriptionByUser(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'user/subscription',
        method: 'POST', body: payload);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Subscription> subscriptions = responseMap
          .map<Subscription>(
              (subscriptionMap) => Subscription.fromJson(subscriptionMap))
          .toList();
      return subscriptions;
    } else {
      print("Debug");
    }
  }

  // ignore: missing_return
  static Future<Subscription> getSubscriptionById(var subscriptionId) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'subscription/$subscriptionId',
        method: 'GET');
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      Subscription subscription = Subscription.fromJson(responseMap);
      return subscription;
    } else {
      print('DEBUG!!!');
    }
  }

  
}
