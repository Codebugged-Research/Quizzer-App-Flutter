import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:quiz_app/services/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PushService {
  static Future<String> genTokenID() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final FirebaseMessaging _fcm = FirebaseMessaging();
    await _fcm.subscribeToTopic("quiz");
    String id = await _fcm.getToken();
    pref.setString("deviceToken", id);
    UserService.updateUser(jsonEncode({"deviceToken": id}));
    return id;
  }

   static Future<String> sendPushtoUser(String title, String message, String vendorId) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var deviceToken = pref.getString("deviceToken");
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": deviceToken, "vendorId": vendorId},
    );
    http.Response response = await http.post(
        "https://www.myzeroapp.com/api/notification/data",
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> sendPushToSelf(String title, String message) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var deviceToken = pref.getString("deviceToken");
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": deviceToken},
    );
    http.Response response = await http.post(
        "https://www.myzeroapp.com/api/notification/singleDevice",
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }

  static Future<String> sendPushToVendor(
      String title, String message, String id) async {
    final Map<String, String> headers = {"Content-Type": "application/json"};
    var body = jsonEncode(
      {"title": title, "message": message, "deviceToken": id},
    );
    http.Response response = await http.post(
        "https://www.myzeroapp.com/api/notification/singleDevice",
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return response.body;
    }
  }
}
