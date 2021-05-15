// To parse this JSON data, do
//
//     final house = houseFromJson(jsonString);

import 'dart:convert';

List<House> houseFromJson(String str) =>
    List<House>.from(json.decode(str).map((x) => House.fromJson(x)));

String houseToJson(List<House> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class House {
  House({
    this.theCorpusName,
    this.theAddress,
    this.theRouteNotes,
    this.theNameSubdivisions,
    this.theCorpusSubdivisionsName,
    this.thePeople,
    this.thePhone,
    this.theEMail,
  });

  String theCorpusName;
  String theAddress;
  String theRouteNotes;
  String theNameSubdivisions;
  String theCorpusSubdivisionsName;
  String thePeople;
  String thePhone;
  String theEMail;

  factory House.fromJson(Map<String, dynamic> json) => House(
        theCorpusName: json["the_corpus_name"],
        theAddress: json["the_address"],
        theRouteNotes: json["the_route_notes"],
        theNameSubdivisions: json["the_name_subdivisions"],
        theCorpusSubdivisionsName: json["the_corpus_subdivisions_name"],
        thePeople: json["the_people"],
        thePhone: json["the_phone"],
        theEMail: json["the_e_mail"],
      );

  Map<String, dynamic> toJson() => {
        "the_corpus_name": theCorpusName,
        "the_address": theAddress,
        "the_route_notes": theRouteNotes,
        "the_name_subdivisions": theNameSubdivisions,
        "the_corpus_subdivisions_name": theCorpusSubdivisionsName,
        "the_people": thePeople,
        "the_phone": thePhone,
        "the_e_mail": theEMail,
      };
}
