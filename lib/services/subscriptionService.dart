import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Subscription.dart';
import 'package:quiz_app/services/authService.dart';

class SubscriptionService extends AuthService {
  static Future<String> createSubscription(var payload) async {
    var auth = await AuthService.getSavedAuth();
    String id = auth['id'];
     http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'subscription/create/$id',
        method: 'POST',
        body: payload);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return '';
    }
  }

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
