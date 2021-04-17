import 'package:angtu_shedule_flutter/models/Setting.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'shedule_angtu.db'),
        onCreate: (db, version) async {
      await db.execute('''
      CREATE TABLE tb_settings (
        id_settings INT PRIMARY KEY,
        student_faculty NVARCHAR(100),
        stunent_group NVARCHAR(50),
        data_start DATE,
        teacher_chairs NVARCHAR(100),
        teacher_name NVARCHAR(100)
      )
      ''');
    }, version: 1);
  }

  //добавление новых настроек
  newSetting(Settings newSetting) async {
    final db = await database;

    var res = await db.rawInsert('''
    INSERT INTO tb_settings (
        id_settings ,
        student_faculty,
        stunent_group ,
        data_start,
        teacher_chairs,
        teacher_name 
      ) VALUES (?,?,?,?,?,?)
    ''', [
      newSetting.idSettings,
      newSetting.studentFaculty,
      newSetting.stunentGroup,
      newSetting.dataStart,
      newSetting.teacherChairs,
      newSetting.teacherChairs,
    ]);
    return res;
  }

  //вывод настроек
  Future<dynamic> getSetting() async {
    final db = await database;
    var res = await db.query("tb_settings");
    if (res.length == 0) {
      return null;
    } else {
      var resMap = res[0];
      return resMap.isNotEmpty ? resMap : Null;
    }
  }
}
