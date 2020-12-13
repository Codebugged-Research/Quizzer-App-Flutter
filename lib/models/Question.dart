class Question {
    Question({
        this.options,
        this.id,
        this.description,
        this.answer,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    List<String> options;
    String id;
    String description;
    String answer;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory Question.fromJson(Map<String, dynamic> json) => Question(
        options: json["options"] == null ? null : List<String>.from(json["options"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        description: json["description"] == null ? null : json["description"],
        answer: json["answer"] == null ? null : json["answer"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "options": options == null ? null : List<dynamic>.from(options.map((x) => x)),
        "_id": id == null ? null : id,
        "description": description == null ? null : description,
        "answer": answer == null ? null : answer,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "__v": v == null ? null : v,
    };
}