import 'dart:convert';

import 'package:quiz_app/models/User.dart';

Subscription subscriptionFromJson(String str) => Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
    Subscription({
        this.id,
        this.user,
        this.validTill,
        this.validFrom,
        this.createdAt,
        this.updatedAt,
    });

    String id;
    User user;
    DateTime validTill;
    DateTime validFrom;
    DateTime createdAt;
    DateTime updatedAt;

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        validTill: json["validTill"] == null ? null : DateTime.parse(json["validTill"]),
        validFrom: json["validFrom"] == null ? null : DateTime.parse(json["validFrom"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user.toJson(),
        "validTill": validTill == null ? null : validTill,
        "validFrom": validFrom == null ? null : validFrom,
        "createdAt": createdAt == null ? null : createdAt,
        "updatedAt": updatedAt == null ? null : updatedAt,
    };
}
