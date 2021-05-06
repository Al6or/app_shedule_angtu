// To parse this JSON data, do
//
//     final sheduleFalse = sheduleFalseFromJson(jsonString);

import 'dart:convert';

List<SheduleFalse> sheduleFalseFromJson(String str) => List<SheduleFalse>.from(
    json.decode(str).map((x) => SheduleFalse.fromJson(x)));

String sheduleFalseToJson(List<SheduleFalse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SheduleFalse {
  SheduleFalse({
    this.theWeek,
    this.theDaysWeek,
    this.theTime,
    this.theDiscipline,
    this.theTypeExperience,
    this.theAboutTheTeacher,
    this.theCorpus,
    this.theAudience,
  });

  String theWeek;
  String theDaysWeek;
  String theTime;
  String theDiscipline;
  String theTypeExperience;
  String theAboutTheTeacher;
  String theCorpus;
  String theAudience;

  factory SheduleFalse.fromJson(Map<String, dynamic> json) => SheduleFalse(
        theWeek: json["the_week"],
        theDaysWeek: json["the_days_week"],
        theTime: json["the_time"],
        theDiscipline: json["the_discipline"],
        theTypeExperience: json["the_type_experience"],
        theAboutTheTeacher: json["the_about_the_teacher"],
        theCorpus: json["the_corpus"],
        theAudience: json["the_audience"],
      );

  Map<String, dynamic> toJson() => {
        "the_week": theWeek,
        "the_days_week": theDaysWeek,
        "the_time": theTime,
        "the_discipline": theDiscipline,
        "the_type_experience": theTypeExperience,
        "the_about_the_teacher": theAboutTheTeacher,
        "the_corpus": theCorpus,
        "the_audience": theAudience,
      };
}
