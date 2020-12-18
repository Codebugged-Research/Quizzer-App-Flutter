// To parse this JSON data, do
//
//     final files = filesFromJson(jsonString);

import 'dart:convert';

List<Files> filesFromJson(String str) => List<Files>.from(json.decode(str).map((x) => Files.fromJson(x)));

String filesToJson(List<Files> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Files {
    Files({
        this.id,
        this.imageUrl,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    String id;
    String imageUrl;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Files.fromJson(Map<String, dynamic> json) => Files(
        id: json["_id"],
        imageUrl: json["imageURL"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "imageURL": imageUrl,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}
