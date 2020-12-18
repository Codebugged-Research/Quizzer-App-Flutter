import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/services/authService.dart';
import 'package:quiz_app/services/userService.dart';

class RazorPayService extends AuthService {
  static Future createOrderId(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'razorPay/orderIdGen',
        method: 'POST',
        body: payload);
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      print(responseMap);
      return responseMap["id"];
    } else {
      return responseMap;
    }
  }

  static Future<String> createContactId(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'razorPay/createContact',
        method: 'POST',
        body: payload);
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      // bool updated = await UserService.updateUser(
      //     jsonEncode({"contactId": responseMap['id']}));

      return responseMap['id'];
    } else {
      print("Debug");
    }
  }

  static Future<String> createFundAccount(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'razorPay/createFundAcct',
        method: 'POST',
        body: payload);
    var responseMap = json.decode(response.body);
    if (response.statusCode == 200) {
      // bool updated = await UserService.updateUser(
      //     jsonEncode({"fundAccount": responseMap['id']}));
      return responseMap['id'];
    } else {
      print("DEBUG");
    }
  }
}
