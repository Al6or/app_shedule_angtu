import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../models/House.dart';

class InfoScreen extends StatefulWidget {
  static const String routeName = "/info";
  @override
  InfoScreenState createState() => InfoScreenState();
}

class InfoScreenState extends State<InfoScreen> {
  List<House> _list = [];

  @override
  void initState() {
    super.initState();

    //расписание ссесии если группа
    Services.getHouse().then((house) {
      setState(() {
        _list = house;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корпуса'),
      ),
      body: SizedBox.expand(
          child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0, 0.1, 0.5, 0.8, 1],
            colors: [
              Color(0xff316899),
              Color(0xff153f65),
              Color(0xff1085c9),
              Color(0xff153f65),
              Color(0xff316899),
            ],
          ),
        ),
        child: GroupedListView<House, String>(
          elements: _list,
          groupBy: (element) => element.theCorpusName,
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item2, item1) =>
              item1.theAddress.compareTo(item2.theAddress),
          order: GroupedListOrder.DESC,
          useStickyGroupSeparators: false,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.only(top: 20),
            child: AccordionTitle(
                value,
                _list
                    .where((e) => e.theCorpusName == value)
                    .map((e) => e.theAddress)
                    .toSet()
                    .toString(),
                _list
                    .where((e) => e.theCorpusName == value)
                    .map((e) => e.theRouteNotes)
                    .toSet()
                    .toString()),
            /* Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),*/
          ),
          itemBuilder: (c, element) {
            return Column(
              children: [
                Accordion(
                  element.theCorpusSubdivisionsName,
                  element.theNameSubdivisions,
                  element.thePeople,
                  element.thePhone,
                  element.theEMail,
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}

class Accordion extends StatefulWidget {
  final String title;
  final String theNameSubdivisions;
  final String thePeople;
  final String thePhone;
  final String theEmail;

  Accordion(
    this.title,
    this.theNameSubdivisions,
    this.thePeople,
    this.thePhone,
    this.theEmail,
  );
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(children: [
        ListTile(
          leading: Icon(
            _showContent
                ? Icons.collections_bookmark_outlined
                : Icons.collections_bookmark,
            size: 35,
            color: Color(0xff153f65),
          ),
          title: Text(widget.title),
          subtitle: Text(widget.thePeople),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 10, left: 20, right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(widget.theNameSubdivisions),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(widget.thePhone),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(widget.theEmail),
                  ],
                ))
            : Container()
      ]),
    );
  }
}

//Корпуса
class AccordionTitle extends StatefulWidget {
  final String title;
  final String theAddress;
  final String theRouteNotes;

  AccordionTitle(this.title, this.theAddress, this.theRouteNotes);
  @override
  _AccordionTitleState createState() => _AccordionTitleState();
}

class _AccordionTitleState extends State<AccordionTitle> {
  bool _showContent = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Column(children: [
        ListTile(
          title: Text(widget.title),
          subtitle: Text(
              widget.theAddress.replaceAll(RegExp(r"[^а-яА-Я0-9\s.,]+"), '')),
          trailing: IconButton(
            icon: Icon(
                _showContent ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
          ),
        ),
        _showContent
            ? Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(bottom: 10, left: 20, right: 5),
                child: Text(widget.theRouteNotes
                    .replaceAll(RegExp(r"[^а-яА-Я0-9\s.,«»№/]+"), '')))
            : Container()
      ]),
    );
  }
}
