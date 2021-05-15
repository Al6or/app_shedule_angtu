import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/screens/Informations/ContainerInfo.dart';
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
  bool _showContent = false;

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
        backgroundColor: Color(0xff153f65),
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
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Column(
              children: [
                Accordion(
                    element.theCorpusSubdivisionsName,
                    element.thePeople,
                    element.thePhone,
                    element.theEMail,
                    element.theAddress,
                    element.theRouteNotes),
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
  final String thePeople;
  final String thePhone;
  final String theEmail;
  final String theAddress;
  final String theRouteNotes;

  Accordion(this.title, this.thePeople, this.thePhone, this.theEmail,
      this.theAddress, this.theRouteNotes);
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
                    Row(children: [
                      Icon(Icons.phone),
                      Text(widget.thePhone),
                    ]),
                    Row(children: [
                      Icon(Icons.alternate_email),
                      Text(widget.theEmail),
                    ]),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(widget.theAddress),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                    ),
                    Text(widget.theRouteNotes)
                  ],
                ))
            : Container()
      ]),
    );
  }
}
