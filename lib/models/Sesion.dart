// To parse this JSON data, do
//
//     final sesion = sesionFromJson(jsonString);

import 'dart:convert';

List<Sesion> sesionFromJson(String str) =>
    List<Sesion>.from(json.decode(str).map((x) => Sesion.fromJson(x)));

String sesionToJson(List<Sesion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sesion {
  Sesion({
    this.theFaculty,
    this.theGrups,
    this.theDate,
    this.theTime,
    this.theDiscipline,
    this.theTypeExperience,
    this.theAboutTheTeacher,
    this.theCorpus,
    this.theAudience,
  });

  String theFaculty;
  String theGrups;
  String theDate;
  String theTime;
  String theDiscipline;
  String theTypeExperience;
  String theAboutTheTeacher;
  String theCorpus;
  String theAudience;

  factory Sesion.fromJson(Map<String, dynamic> json) => Sesion(
        theFaculty: json["the_faculty"],
        theGrups: json["the_grups"],
        theDate: json["the_date"],
        theTime: json["the_time"],
        theDiscipline: json["the_discipline"],
        theTypeExperience: json["the_type_experience"],
        theAboutTheTeacher: json["the_about_the_teacher"],
        theCorpus: json["the_corpus"],
        theAudience: json["the_audience"],
      );

  Map<String, dynamic> toJson() => {
        "the_faculty": theFaculty,
        "the_grups": theGrups,
        "the_date": theDate,
        "the_time": theTime,
        "the_discipline": theDiscipline,
        "the_type_experience": theTypeExperience,
        "the_about_the_teacher": theAboutTheTeacher,
        "the_corpus": theCorpus,
        "the_audience": theAudience,
      };
}
