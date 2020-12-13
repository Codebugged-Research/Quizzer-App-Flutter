import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/services/authService.dart';

class QuizService extends AuthService {
  static Future<List<Quiz>> getAllQuiz() async {
    http.Response response = await AuthService.makeAuthenticatedRequest(
        AuthService.BASE_URI + 'quiz/app/quiz',
        method: 'GET');
    if (response.statusCode == 200) {
      var responseMap = json.decode(response.body);
      List<Quiz> quizes =
          responseMap.map<Quiz>((quizMap) => Quiz.fromJson(quizMap)).toList();
      return quizes;
    } else {
      print("DEBUG");
    }
  }
}
