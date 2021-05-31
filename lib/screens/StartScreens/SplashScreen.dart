import 'dart:async';

import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/material.dart';

bool _load() {
  bool n = false;
  if (SharedPrefs().user != selectUser &&
      (SharedPrefs().teacher != selectTeacher ||
          SharedPrefs().group != selectGroup)) {
    n = true;
  }
  return n;
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => Navigator.pushNamed(context, "/introSetting")
      /*_load()
          ? Navigator.pushNamed(context, "/home")
          : Navigator.pushNamed(context, "/introSetting")*/
      ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/logo1.png'),
                                  fit: BoxFit.cover))),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        'Расписание\nуниверситета АнГТУ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff153f65),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'Пожалуйста подождите...',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color(0xff153f65),
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
