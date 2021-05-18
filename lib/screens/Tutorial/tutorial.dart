import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/tutorial.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:angtu_shedule_flutter/screens/Shedule/home.dart';
import 'package:angtu_shedule_flutter/screens/Tutorial/ContainerTutorial.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:angtu_shedule_flutter/models/Chairs.dart';
import 'package:flutter/cupertino.dart';

String _returnNameValue;

class ListChairForTutorial extends StatefulWidget {
  static const String routeName = "/tutorial";

  @override
  _ListChairForTutorialState createState() => _ListChairForTutorialState();
}

class _ListChairForTutorialState extends State<ListChairForTutorial> {
  List<Chairs> _chairs;
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getChairs().then((chairs) {
      setState(() {
        _chairs = chairs;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? valueLoad : selectChair),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: null == _chairs ? 0 : _chairs.length,
          itemBuilder: (context, index) {
            Chairs chairs = _chairs[index];
            return ListTile(
                title: Text(chairs.theChair),
                leading: Icon(
                  Icons.auto_stories,
                  color: Color(0xff153f65),
                ),
                trailing: Icon(
                  Icons.arrow_right,
                  color: Color(0xff153f65),
                ),
                onTap: () {
                  setState(() {
                    _returnNameValue = chairs.theChair;
                    _awaitReturnValueListChair(context);
                  });
                });
          },
        ),
      ),
    );
  }

  //выбранная кафедра
  void _awaitReturnValueListChair(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TutorialScreen(),
        ));
    setState(() {
      _returnNameValue = result ?? selectChair; //сохранение значение локально
    });
  }
}

class TutorialScreen extends StatefulWidget {
  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends State<TutorialScreen> {
  PageController _pageController;
  int _currentIndex = nowNumberWeek();

  List<Tutorial> _listFalse = [];
  List<Tutorial> _listTrue = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: nowNumberWeek());

    Services.getTutorial(_returnNameValue, false).then((group) {
      setState(() {
        _listFalse = group;
      });
    });
    //Нечетная неделя
    Services.getTutorial(_returnNameValue, true).then((group) {
      setState(() {
        _listTrue = group;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_returnNameValue),
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            containerTutorial(_listFalse),
            containerTutorial(_listTrue),
          ],
        ),
      ),
      //навигатор нижний
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xff153f65),
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(
            () => _currentIndex = index,
          );
          _pageController.jumpToPage(index);
        },
        mainAxisAlignment: MainAxisAlignment.center,
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Чётная'),
              icon: Icon(Icons.home),
              activeColor: Colors.white),
          BottomNavyBarItem(
              title: Text('Нечётная'),
              icon: Icon(Icons.apps),
              activeColor: Colors.yellow[300]),
        ],
      ),
    );
  }
}
