// To parse this JSON data, do
//
//     final offer = offerFromJson(jsonString);

import 'dart:convert';

List<Offer> offerFromJson(String str) => List<Offer>.from(json.decode(str).map((x) => Offer.fromJson(x)));

String offerToJson(List<Offer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Offer {
  Offer({
    this.redeems,
    this.id,
    this.name,
    this.type,
    this.description,
    this.amount,
    this.percentage,
    this.start,
    this.end,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  int redeems;
  String id;
  String name;
  String type;
  String description;
  String amount;
  String percentage;
  String start;
  String end;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
    redeems: json["redeems"] == null ? null : json["redeems"],
    id: json["_id"] == null ? null : json["_id"],
    name: json["name"] == null ? null : json["name"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : json["description"],
    amount: json["amount"] == null ? null : json["amount"],
    percentage: json["percentage"] == null ? null : json["percentage"],
    start: json["start"] == null ? null : json["start"],
    end: json["end"] == null ? null : json["end"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"] == null ? null : json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "redeems": redeems == null ? null : redeems,
    "_id": id == null ? null : id,
    "name": name == null ? null : name,
    "type": type == null ? null : type,
    "description": description == null ? null : description,
    "amount": amount == null ? null : amount,
    "percentage": percentage == null ? null : percentage,
    "start": start == null ? null : start,
    "end": end == null ? null : end,
    "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
    "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    "__v": v == null ? null : v,
  };
}
