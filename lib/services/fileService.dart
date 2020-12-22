import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/File.dart';
import 'package:quiz_app/models/feed.dart';
import 'package:quiz_app/services/authService.dart';

class FileService extends AuthService {
  // ignore: missing_return
  static Future<List<Files>> getallcards() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'file/allcards',
        method: 'GET');
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Files> files =
          responseMap.map<Files>((fileMap) => Files.fromJson(fileMap)).toList();
      return files;
    } else {
      print("DEBUG");
    }
  }
  // ignore: missing_return
  static Future<List<Feed>> getallfeed() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'feed/get',
        method: 'GET');
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Feed> files =
          responseMap.map<Feed>((fileMap) => Feed.fromJson(fileMap)).toList();
      return files;
    } else {
      print("DEBUG");
    }
  }

}
