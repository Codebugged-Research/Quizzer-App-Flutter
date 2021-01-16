import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Response.dart';
import 'package:quiz_app/services/authService.dart';

class ResponseService extends AuthService {

  //Submit Response
  static Future<bool> submitResponse(var payload) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'response/submit',
        method: 'POST',
        body: payload);
        print("galti");
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
  
  // ignore: missing_return
  static Future<List<Response>> getResponseByUser(var id) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'response/getByUser/$id',
        method: 'GET');
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
  static Future<List<Response>> getResponseByQuiz(var id) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'response/getByQuiz/$id',
        method: 'GET');
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
  static Future<List<Response>> getResponseByUserDate(var id) async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'response/UserDate/$id/${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}',
        method: 'GET');
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
