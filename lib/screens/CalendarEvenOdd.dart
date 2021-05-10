import 'package:angtu_shedule_flutter/appData/Services.dart';
import 'package:angtu_shedule_flutter/models/Shedule.dart';
import 'package:angtu_shedule_flutter/screens/globals.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:week_of_year/week_of_year.dart';

class CalendarEvenOddScreen extends StatefulWidget {
  static const String routeName = "/calendar";
  @override
  _CalendarEvenOddState createState() => _CalendarEvenOddState();
}

class _CalendarEvenOddState extends State<CalendarEvenOddScreen> {
  ValueNotifier<List<Shedule>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;

  List<Shedule> _listFalse = [];
  List<Shedule> _listTrue = [];

  DateTime kNow = DateFormat('dd.MM.yyyy').parse(SharedPrefs().dateStart);
  DateTime kFirstDay;
  DateTime kLastDay;

  @override
  void initState() {
    super.initState();
    kFirstDay = DateTime(kNow.year, kNow.month - 1, kNow.day);
    kLastDay = DateTime(kNow.year, kNow.month + 6, kNow.day);

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
    if (SharedPrefs().user == headStudent) {
      //расписание если группа
      //четная неделя
      Services.getSheduleGroup(SharedPrefs().group, false).then((group) {
        setState(() {
          _listFalse = group;
        });
      });
      //Нечетная неделя
      Services.getSheduleGroup(SharedPrefs().group, true).then((group) {
        setState(() {
          _listTrue = group;
        });
      });
    } else {
      //расписание если преподаватель
      //четная неделя
      Services.getSheduleTeacher(SharedPrefs().teacher, false).then((teacher) {
        setState(() {
          _listFalse = teacher;
        });
      });
      //Нечетная неделя
      Services.getSheduleTeacher(SharedPrefs().teacher, true).then((teacher) {
        setState(() {
          _listTrue = teacher;
        });
      });
    }
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Shedule> _getEventsForDay(DateTime day) {
    for (int i = 1; i < 8; i++) {
      if (day.weekOfYear % 2 == 0) {
        //четная/нечетная неделя
        if (day.weekday == i) {
          return _listFalse
              .where((element) => element.theDaysWeek == i.toString())
              .toList();
        }
      } else {
        if (day.weekday == i) {
          return _listTrue
              .where((element) => element.theDaysWeek == i.toString())
              .toList();
        }
      }
    }
    return [];
  }

  List<Shedule> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff153f65),
        title: Text(headShedule),
      ),
      body: Column(
        children: [
          TableCalendar<Shedule>(
            locale: 'ru_RU',
            availableCalendarFormats: const {
              CalendarFormat.month: 'Месяц',
              CalendarFormat.week: 'Неделя',
              CalendarFormat.twoWeeks: 'Две недели',
            },
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              outsideDaysVisible: false,
              markersMaxCount: 6,
            ),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ValueListenableBuilder<List<Shedule>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    Shedule sheduleFalse = value[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        //color: Color(0xff153f65),
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: name(sheduleFalse),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

ListTile name(Shedule sheduleFalse) {
  String name;
  if (SharedPrefs().user == headStudent) {
    name = sheduleFalse.theAboutTheTeacher;
  } else {
    name = sheduleFalse.theGrups;
  }
  return ListTile(
    leading: Text(
      sheduleFalse.theTime,
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    title: Text(sheduleFalse.theDiscipline),
    subtitle: Text(sheduleFalse.theTypeExperience + " " + name),
    trailing: Text(sheduleFalse.theCorpus + "\n" + sheduleFalse.theAudience),
  );
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}
