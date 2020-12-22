import 'dart:convert';

import 'package:quiz_app/models/Quiz.dart';
import 'package:quiz_app/models/User.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
    Response({
        this.id,
        this.correct,
        this.wrong,
        this.user,
        this.quiz,
        this.reward,
        this.userRole,
        this.score,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    String correct;
    String wrong;
    User user;
    Quiz quiz;
    String reward;
    String score;
    String userRole;
    DateTime createdAt;
    DateTime updatedAt;

    factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: json["_id"] == null ? null : json["_id"],
        correct: json["correct"] == null ? null : json["correct"],
        wrong: json["wrong"] == null ? null : json["wrong"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        quiz: json["quiz"] == null ? null :  Quiz.fromJson(json["quiz"]),
        reward: json["reward"] == null ? null : json["reward"],
        score: json["score"] == null ? null : json["score"],
        userRole: json["userRole"]==null?null: json["userRole"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "correct": correct == null ? null : correct,
        "wrong": wrong == null ? null : wrong,
        "user": user == null ? null : user.toJson(),
        "quiz": quiz == null ? null : quiz.toJson(),
        "reward": reward == null ? null : reward,
        "score": score == null ? null : score,
        "userRole": userRole ==null ? null:userRole,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
