import 'package:healthone/mentalhealth_folder/mental_add_event.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {

  String _stress = 'low';

  late Map<DateTime, List<Event>> selectedEvents;
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  TextEditingController _eventController = TextEditingController();

  @override
  void initState() {
    selectedEvents = {};
    super.initState();
  }

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Mental Health: Mood and Stress")),
        backgroundColor: Colors.teal[400],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2050),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat _format) {
              setState(() {
                format = _format;
              });
            },
            startingDayOfWeek: StartingDayOfWeek.sunday,
            daysOfWeekVisible: true,

            //Day Changed
            onDaySelected: (DateTime selectDay, DateTime focusDay) {
              setState(() {
                selectedDay = selectDay;
                focusedDay = focusDay;
              });
              print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },

            eventLoader: _getEventsfromDay,

            //To style the Calendar
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayDecoration: BoxDecoration(
                color: Colors.purpleAccent,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: true,
              titleCentered: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(5.0),
              ),
              formatButtonTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          ..._getEventsfromDay(selectedDay).map(
            (Event event) => ListTile(
              title: Text(
                event.title,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Select stress level and mood"),
            // content: TextFormField(
            //   controller: _eventController,
            // ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: const Text('low'),
                  leading: Radio<String>(
                    value: 'low',
                    groupValue: _stress,
                    onChanged: (String? value) {
                      setState(() {
                        _stress = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('regular'),
                  leading: Radio<String>(
                    value: 'regular',
                    groupValue: _stress,
                    onChanged: (String? value) {
                      setState(() {
                        _stress = value!;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: const Text('high'),
                  leading: Radio<String>(
                    value: 'high',
                    groupValue: _stress,
                    onChanged: (String? value) {
                      setState(() {
                        _stress = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            //   ]
            // )
            actions: [
              TextButton(
                child: Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text("Negative",
                style: TextStyle(color: Colors.red[700])),
                onPressed: () {
                  // _eventController.text = "Negative";
                  print("==========ADD HERE============");
                  MentalData().addStressMood("tempUserName","negative", _stress, selectedDay.month.toString(), selectedDay.day.toString(), selectedDay.year.toString());
                  print("==========FINISHED ADDING============");

                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: "Stress: " + _stress + " | Mood: negative"),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: "Stress: " + _stress + " | Mood: negative")
                      ];
                    }

                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
              TextButton(
                child: Text("Neutral",
                style: TextStyle(color: Colors.yellow[800])),
                onPressed: () {
                  // _eventController.text = "Neutral";
                  print("==========ADD HERE============");
                  MentalData().addStressMood("tempUserName", "neutral", _stress, selectedDay.month.toString(), selectedDay.day.toString(), selectedDay.year.toString());
                  print("==========FINISHED ADDING============");

                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: "Stress: " + _stress + " | Mood: neutral"),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: "Stress: " + _stress + " | Mood: neutral")
                      ];
                    }

                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
              TextButton(
                child: Text("Positive",
                style: TextStyle(color: Colors.green[800])),
                onPressed: () {
                  // _eventController.text = "Positive";
                  print("==========ADD HERE============");
                  MentalData().addStressMood("tempUserName", "positive", _stress, selectedDay.month.toString(), selectedDay.day.toString(), selectedDay.year.toString());
                  print("==========FINISHED ADDING============");
                  
                    if (selectedEvents[selectedDay] != null) {
                      selectedEvents[selectedDay]!.add(
                        Event(title: "Stress: " + _stress + " | Mood: positive"),
                      );
                    } else {
                      selectedEvents[selectedDay] = [
                        Event(title: "Stress: " + _stress + " | Mood: positive")
                      ];
                    }

                  Navigator.pop(context);
                  _eventController.clear();
                  setState((){});
                  return;
                },
              ),
            ],
          ),
        ),
        label: Text("Add Mood and Stress"),
        icon: Icon(Icons.add),
      ),
    );
  }
}