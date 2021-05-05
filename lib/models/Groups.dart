// To parse this JSON data, do
//
//     final groups = groupsFromJson(jsonString);

import 'dart:convert';

List<Groups> groupsFromJson(String str) =>
    List<Groups>.from(json.decode(str).map((x) => Groups.fromJson(x)));

String groupsToJson(List<Groups> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Groups {
  Groups({
    this.theFaculty,
    this.theGrups,
  });

  String theFaculty;
  String theGrups;

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
        theFaculty: json["the_faculty"],
        theGrups: json["the_grups"],
      );

  Map<String, dynamic> toJson() => {
        "the_faculty": theFaculty,
        "the_grups": theGrups,
      };
}
