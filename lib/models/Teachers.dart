// To parse this JSON data, do
//
//     final teachers = teachersFromJson(jsonString);

import 'dart:convert';

List<Teachers> teachersFromJson(String str) =>
    List<Teachers>.from(json.decode(str).map((x) => Teachers.fromJson(x)));

String teachersToJson(List<Teachers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Teachers {
  Teachers({
    this.theChair,
    this.theTeacher,
  });

  String theChair;
  String theTeacher;

  factory Teachers.fromJson(Map<String, dynamic> json) => Teachers(
        theChair: json["the_cathedra"],
        theTeacher: json["the_people"],
      );

  Map<String, dynamic> toJson() => {
        "the_cathedra": theChair,
        "the_people": theTeacher,
      };
}
