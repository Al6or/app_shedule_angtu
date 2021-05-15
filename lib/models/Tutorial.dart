// To parse this JSON data, do
//
//     final tutorial = tutorialFromJson(jsonString);

import 'dart:convert';

List<Tutorial> tutorialFromJson(String str) =>
    List<Tutorial>.from(json.decode(str).map((x) => Tutorial.fromJson(x)));

String tutorialToJson(List<Tutorial> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tutorial {
  Tutorial({
    this.thePeople,
    this.theWeek,
    this.theDaysWeek,
    this.theCorpus,
    this.theAudience,
    this.theTime,
  });
  String theCorpusSubdivisionsName;
  String thePeople;
  String theWeek;
  String theDaysWeek;
  String theCorpus;
  String theAudience;
  String theTime;

  factory Tutorial.fromJson(Map<String, dynamic> json) => Tutorial(
        thePeople: json["the_people"],
        theWeek: json["the_week"],
        theDaysWeek: json["the_days_week"],
        theCorpus: json["the_corpus"],
        theAudience: json["the_audience"],
        theTime: json["the_time"],
      );

  Map<String, dynamic> toJson() => {
        "the_people": thePeople,
        "the_week": theWeek,
        "the_days_week": theDaysWeek,
        "the_corpus": theCorpus,
        "the_audience": theAudience,
        "the_time": theTime,
      };
}
