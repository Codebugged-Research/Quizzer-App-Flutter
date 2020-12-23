// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:quiz_app/models/Subscription.dart';

List<User> userFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.interests,
    this.role,
    this.id,
    this.name,
    this.email,
    this.phone,
    this.reward,
    this.subscription,
    this.password,
    this.photoUrl,
    this.contactId,
    this.fundAccount,
    this.username,
    this.upiId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  List<dynamic> interests;
  String role;
  String id;
  String name;
  String phone;
  String reward;
  Subscription subscription;
  String email;
  String password;
  String photoUrl;
  String contactId;
  String fundAccount;
  String username;
  String upiId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        interests: json["interests"] == null
            ? null
            : List<dynamic>.from(json["interests"].map((x) => x)),
        role: json["role"] == null ? null : json["role"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        photoUrl: json["photoUrl"] == null ? "https://i.picsum.photos/id/1011/5472/3648.jpg" : json["photoUrl"],
        phone: json["phone"] == null ? null : json["phone"],
        upiId: json["upiId"] == null ? null : json["upiId"],
        username: json["username"] == null ? null : json["username"],
        reward: json["reward"] == null ? "0" : json["reward"],
        email: json["email"] == null ? null : json["email"],
        contactId: json["contactId"] == null ? null : json["contactId"],
        fundAccount: json["fundAccount"] == null ? null : json["fundAccount"],
        password: json["password"] == null ? null : json["password"],
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "interests": interests == null
            ? null
            : List<dynamic>.from(interests.map((x) => x)),
        "role": role == null ? null : role,
        "_id": id == null ? null : id,
        "phone": phone == null ? null : phone,
        "name": name == null ? null : name,
        "photoUrl": photoUrl == null ? null : photoUrl,
        "username": username == null ? null : username,
        "reward": reward == null ? null : reward,
        "email": email == null ? null : email,
        "subscription": subscription == null ? null : subscription.toJson(),
        "password": password == null ? null : password,
        "fundAccount": fundAccount == null ? null : fundAccount,
        "upiId": upiId == null ? null : upiId,
        "contactId": contactId == null ? null : contactId,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
