// To parse this JSON data, do
//
//     final sheduleFalse = sheduleFalseFromJson(jsonString);

import 'dart:convert';

List<Shedule> sheduleFalseFromJson(String str) =>
    List<Shedule>.from(json.decode(str).map((x) => Shedule.fromJson(x)));

String sheduleFalseToJson(List<Shedule> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Shedule {
  Shedule(
      {this.theWeek,
      this.theDaysWeek,
      this.theTime,
      this.theDiscipline,
      this.theTypeExperience,
      this.theAboutTheTeacher,
      this.theCorpus,
      this.theAudience,
      this.theFaculty,
      this.theGrups});

  String theWeek;
  String theDaysWeek;
  String theTime;
  String theDiscipline;
  String theTypeExperience;
  String theAboutTheTeacher;
  String theCorpus;
  String theAudience;
  String theFaculty;
  String theGrups;

  factory Shedule.fromJson(Map<String, dynamic> json) => Shedule(
        theWeek: json["the_week"],
        theDaysWeek: json["the_days_week"],
        theTime: json["the_time"],
        theDiscipline: json["the_discipline"],
        theTypeExperience: json["the_type_experience"],
        theAboutTheTeacher: json["the_about_the_teacher"],
        theCorpus: json["the_corpus"],
        theAudience: json["the_audience"],
        theFaculty: json["the_faculty"],
        theGrups: json["the_grups"],
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
        "the_faculty": theFaculty,
        "the_grups": theGrups,
      };
}
