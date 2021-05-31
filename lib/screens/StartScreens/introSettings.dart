import 'dart:ui';

import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/studSettings.dart';
import 'package:angtu_shedule_flutter/screens/StartScreens/teachSettings.dart';
import 'package:flutter/material.dart';

class IntroSettingScreen extends StatefulWidget {
  static const String routeName = "/introSetting";

  @override
  IntroSettingScreenState createState() => IntroSettingScreenState();
}

class IntroSettingScreenState extends State<IntroSettingScreen> {
  final List<String> items = <String>[selectUser, headTeacher, headStudent];
  String selectedItem = selectUser;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          child: Center(
            child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/logo1.png'),
                                fit: BoxFit.cover))),
                    Text(
                      'Расписание\nуниверситета АнГТУ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff153f65),
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.0),
                    ),
                    Text(
                      'Добро пожаловать',
                      style: TextStyle(
                        color: Color(0xff153f65),
                        fontFamily: 'JostSemiBold',
                        fontSize: 35,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    ),
                    SizedBox(
                        width: 300,
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Icon(Icons.supervisor_account),
                            trailing: DropdownButton<String>(
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Color(0xff153f65),
                              ),
                              iconSize: 40,
                              elevation: 16,
                              style: const TextStyle(
                                color: Color(0xff03131f),
                              ),
                              underline: Container(
                                height: 2,
                                color: Color(0xffffffff),
                              ),
                              value: selectedItem,
                              onChanged: (String string) =>
                                  setState(() => selectedItem = string),
                              selectedItemBuilder: (BuildContext context) {
                                return items.map<Widget>((String item) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                        color: Color(0xff153f65),
                                        fontFamily: 'JostMedium',
                                        fontSize: 19,
                                      ),
                                    ),
                                  );
                                }).toList();
                              },
                              items: items.map((String item) {
                                return DropdownMenuItem<String>(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      item,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontFamily: 'JostMedium'),
                                    ),
                                  ),
                                  value: item,
                                );
                              }).toList(),
                            ),
                            onTap: () {},
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(5),
                    ),
                    SizedBox(
                      width: 300,
                      child: Card(
                        color: Color(0xff153f65),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            "Продолжить",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                          onTap: () {
                            SharedPrefs().user = selectedItem;
                            _btNext(context);
                          },
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}

void _btNext(BuildContext context) async {
  if (SharedPrefs().user == headStudent) {
    SharedPrefs().routeNameSetting = StudSettingScreen.routeName;
    // pop - закрыть текующую страницу
    Navigator.of(context).pop();
    // pushNamed -  перейти к маршруту
    Navigator.of(context).pushNamed(StudSettingScreen.routeName);
  }
  if (SharedPrefs().user == headTeacher) {
    SharedPrefs().routeNameSetting = TeachSettingScreen.routeName;
    // pop - закрыть текующую страницу
    Navigator.of(context).pop();
    // pushNamed -  перейти к маршруту
    Navigator.of(context).pushNamed(TeachSettingScreen.routeName);
  }
  if (SharedPrefs().user == selectUser) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        action: SnackBarAction(
          label: 'ок',
          textColor: Color(0xff1085c9),
          onPressed: () {},
        ),
        content: const Text('Нужно выбрать что нибудь!'),
        duration: const Duration(milliseconds: 1500),
        width: 300, //Ширина
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
