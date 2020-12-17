// To parse this JSON data, do
//
//     final quiz = quizFromJson(jsonString);

import 'dart:convert';

import 'package:quiz_app/models/Question.dart';

List<Quiz> quizFromJson(String str) => List<Quiz>.from(json.decode(str).map((x) => Quiz.fromJson(x)));

String quizToJson(List<Quiz> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Quiz {
    Quiz({
        this.questions,
        this.correctScore,
        this.incorrectScore,
        this.id,
        this.name,
        this.slot,
        this.reward,
        this.date,
        this.startTime,
        this.endTime,
        this.minutes,
        this.seconds,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<Question> questions;
    String correctScore;
    String incorrectScore;
    String id;
    String name;
    String slot;
    String startTime;
    String endTime;
    String minutes;
    String seconds;
    String reward;
    String date;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        questions: json["questions"] == null ? null : List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        correctScore: json["correct_score"] == null ? null : json["correct_score"],
        incorrectScore: json["incorrect_score"] == null ? null : json["incorrect_score"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        slot: json["slot"] == null ? null : json["slot"],
        seconds: json["seconds"] == null ? "0": json["seconds"],
        minutes: json["minutes"] == null ? "0" : json["minutes"],
        reward: json["reward"] == null ? "0" : json["reward"],
        date: json["date"] == null ? null : json["date"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "questions": questions == null ? null : List<dynamic>.from(questions.map((x) => x.toJson())),
        "correct_score": correctScore == null ? null : correctScore,
        "incorrect_score": incorrectScore == null ? null : incorrectScore,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "slot": slot == null ? null : slot,
        "seconds": seconds == null ? "0" : seconds,
        "minutes": minutes == null ? "0" : minutes,
        "reward": reward == null ? "0" : reward,
        "date": date == null ? null : date,
        "startTime": startTime == null ? null : startTime,
        "endTime": endTime == null ? null : endTime,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}

