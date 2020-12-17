import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/services/authService.dart';

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
}
