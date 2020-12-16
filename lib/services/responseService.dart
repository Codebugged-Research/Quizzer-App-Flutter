import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/services/authService.dart';

class ResponseService extends AuthService {

  //Submit Response
  static Future<bool> submitResponse(var payload) async {
    var auth = await AuthService.getSavedAuth();
    String id = auth['id'];
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'subscription/create/$id',
        method: 'POST',
        body: payload);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  static Future<List<Response>> getResponseByUser(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'user/subscription',
        method: 'POST', body: payload);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Response> responses = responseMap
          .map<Response>(
              (responseMap) => Response.fromJson(responseMap))
          .toList();
      return responses;
    } else {
      print("Debug");
    }
  }

  // ignore: missing_return
  static Future<List<Response>> getResponseByQuiz(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'user/subscription',
        method: 'POST', body: payload);
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Response> responses = responseMap
          .map<Response>(
              (responseMap) => Response.fromJson(responseMap))
          .toList();
      return responses;
    } else {
      print("Debug");
    }
  }

}
