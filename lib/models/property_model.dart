// To parse this JSON data, do
//
//     final property = propertyFromJson(jsonString);

import 'dart:convert';

Property propertyFromJson(String str) => Property.fromJson(json.decode(str));
String propertyToJson(Property data) => json.encode(data.toJson());

class Property {
    Property({
        this.id,
        this.title,
        this.type,
        this.arrays,
    });

    int? id;
    String? title;
    int? type;
    String? arrays;

    factory Property.fromJson(Map<String, dynamic> json) => Property(
        id: json["id"],
        title: json["title"],
        type: json["type"],
        arrays: json["arrays"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "type": type,
        "arrays": arrays,
    };
}
