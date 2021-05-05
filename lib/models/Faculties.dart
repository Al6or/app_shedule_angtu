// To parse this JSON data, do
//
//     final faculties = facultiesFromJson(jsonString);

import 'dart:convert';

List<Faculties> facultiesFromJson(String str) =>
    List<Faculties>.from(json.decode(str).map((x) => Faculties.fromJson(x)));

String facultiesToJson(List<Faculties> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faculties {
  Faculties({
    this.theFaculty,
  });

  String theFaculty;

  factory Faculties.fromJson(Map<String, dynamic> json) => Faculties(
        theFaculty: json["the_faculty"],
      );

  Map<String, dynamic> toJson() => {
        "the_faculty": theFaculty,
      };
}
