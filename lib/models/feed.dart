// To parse this JSON data, do
//
//     final feed = feedFromJson(jsonString);

import 'dart:convert';

Feed feedFromJson(String str) => Feed.fromJson(json.decode(str));

String feedToJson(Feed data) => json.encode(data.toJson());

class Feed {
    Feed({
        this.id,
        this.fileUrl,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String fileUrl;
    String name;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["_id"] == null ? null : json["_id"],
        fileUrl: json["fileURL"] == null ? null : json["fileURL"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "fileURL": fileUrl == null ? null : fileUrl,
        "name": name == null ? null : name,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}
