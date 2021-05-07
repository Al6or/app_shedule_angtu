//список кафедр
import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Chairs.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListChair extends StatefulWidget {
  @override
  _ListChairState createState() => _ListChairState();
}

class _ListChairState extends State<ListChair> {
  String returnNameValue;
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
        backgroundColor: Color(0xff153f65),
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
                    returnNameValue = chairs.theChair;
                    _sendDataBack(context);
                  });
                });
          },
        ),
      ),
    );
  }

  //возвращаемое значение (факультет)
  void _sendDataBack(BuildContext context) {
    String textToSendBack = returnNameValue;
    Navigator.pop(context, textToSendBack);
  }
}
