import 'dart:convert';

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
    String user;
    DateTime validTill;
    DateTime validFrom;
    DateTime createdAt;
    DateTime updatedAt;

    factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        validTill: json["validTill"] == null ? null : DateTime.parse(json["validTill"]),
        validFrom: json["validFrom"] == null ? null : DateTime.parse(json["validFrom"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "validTill": validTill == null ? null : validTill.toIso8601String(),
        "validFrom": validFrom == null ? null : validFrom.toIso8601String(),
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
