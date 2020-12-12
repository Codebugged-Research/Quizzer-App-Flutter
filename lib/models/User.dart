// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(String str) => List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String userToJson(List<User> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
    User({
        this.interests,
        this.role,
        this.id,
        this.name,
        this.email,
        this.password,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<dynamic> interests;
    String role;
    String id;
    String name;
    String email;
    String password;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory User.fromJson(Map<String, dynamic> json) => User(
        interests: json["interests"] == null ? null : List<dynamic>.from(json["interests"].map((x) => x)),
        role: json["role"] == null ? null : json["role"],
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "interests": interests == null ? null : List<dynamic>.from(interests.map((x) => x)),
        "role": role == null ? null : role,
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
