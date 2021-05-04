import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Group.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class ExamScreen extends StatefulWidget {
  static const String routeName = "/exam";
  @override
  _ListState createState() => _ListState();
}

class _ListState extends State<ExamScreen> {
  List<Group> _group = [];
  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getExam().then((group) {
      setState(() {
        _group = group;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Загрузка...' : 'Группированый список'),
      ),
      body: GroupedListView<Group, String>(
        elements: _group,
        groupBy: (element) => element.postId.toString(),
        groupComparator: (value1, value2) => value2.compareTo(value1),
        itemComparator: (item1, item2) => item1.id.compareTo(item2.id),
        order: GroupedListOrder.DESC,
        useStickyGroupSeparators: true,
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (context, element) {
          return Card(
            elevation: 8.0,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text(element.email),
              ),
            ),
          );
        },
      ),
    );
  }
}
