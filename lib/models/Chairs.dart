// To parse this JSON data, do
//
//     final chairs = chairsFromJson(jsonString);

import 'dart:convert';

List<Chairs> chairsFromJson(String str) =>
    List<Chairs>.from(json.decode(str).map((x) => Chairs.fromJson(x)));

String chairsToJson(List<Chairs> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chairs {
  Chairs({
    this.theChair,
  });

  String theChair;

  factory Chairs.fromJson(Map<String, dynamic> json) => Chairs(
        theChair: json["the_cathedra"],
      );

  Map<String, dynamic> toJson() => {
        "the_cathedra": theChair,
      };
}
