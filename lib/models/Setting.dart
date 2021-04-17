// To parse this JSON data, do
//
//     final settings = settingsFromJson(jsonString);

import 'dart:convert';

List<Settings> settingsFromJson(String str) =>
    List<Settings>.from(json.decode(str).map((x) => Settings.fromJson(x)));

String settingsToJson(List<Settings> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Settings {
  Settings({
    this.idSettings,
    this.studentFaculty,
    this.stunentGroup,
    this.dataStart,
    this.teacherChairs,
    this.teacherName,
  });

  int idSettings;
  String studentFaculty;
  String stunentGroup;
  String dataStart;
  String teacherChairs;
  String teacherName;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        idSettings: json["id_settings"],
        studentFaculty: json["student_faculty"],
        stunentGroup: json["stunent_group"],
        dataStart: json["data_start"],
        teacherChairs: json["teacher_chairs"],
        teacherName: json["teacher_name"],
      );

  Map<String, dynamic> toJson() => {
        "id_settings": idSettings,
        "student_faculty": studentFaculty,
        "stunent_group": stunentGroup,
        "data_start": dataStart,
        "teacher_chairs": teacherChairs,
        "teacher_name": teacherName,
      };
}
