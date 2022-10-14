import 'package:flutter/material.dart';
import 'package:healthone/study_habits_folder/study_folder/activity_data.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:healthone/study_habits_folder/classes_folder/classesdb_service.dart';
import 'package:healthone/study_habits_folder/classes_folder/study_class.dart';
import 'package:healthone/study_habits_folder/classes_folder/class_data.dart';

class StudyTimer extends StatefulWidget {
  const StudyTimer({Key? key}) : super(key: key);

  @override
  _StudyTimerState createState() => _StudyTimerState();
}

class _StudyTimerState extends State<StudyTimer> {
  List<StudyClass>? classes;
  List<String>? classesString;
  static const countdownDuration = Duration(minutes: 10);
  Duration duration = Duration();
  String _curClass = '';
  Timer? timer;

  bool isCountDown = false;

  getClasses() async {
    classes = await ClassesDBService.getClasses();
    Provider.of<ClassData>(context, listen: false).classes = classes!;
    classes?.forEach((element) {
      print(element);
    });
    setState(() {});
  }

  transformClasses() async {
    classesString = classes?.map<String>(
      (StudyClass c) {
        return '${c.semester}-${c.code}';
      },
    ).toList();
  }

  @override
  void initState() {
    super.initState();
    getClasses();
    transformClasses();
    reset();
  }

  void reset() {
    if (isCountDown) {
      setState(() => duration = countdownDuration);
    } else {
      setState(() => duration = Duration());
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    final addSeconds = isCountDown ? -1 : 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      if (seconds < 0) {
        timer?.cancel();
      } else {
        duration = Duration(seconds: seconds);
      }
    });
  }

  void stopTimer({bool resets = true}) {
    if (resets) {
      showAddActivityDialog();
      reset();
    }
    setState(() => timer?.cancel());
  }

  void showAddActivityDialog() {
    String _curDuration = duration.toString();
    int _intDuration = duration.inSeconds;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Finish studying?\nAdd this study session:"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Class code: ${_curClass.substring(7)}"),
                  Text("Semester: ${_curClass.substring(0, 6)}"),
                  Text("Duration: " + _curDuration),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ButtonWidget(
                          text: "Add",
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          onClicked: () {
                            print("=========Add Activity==========");
                            ActivityData().addActivity(_curClass.substring(7),
                                _curClass.substring(0, 6), _intDuration);
                            print("=========Finish Adding==========");
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          }),
                      ButtonWidget(
                          text: "Cancel",
                          color: Colors.black,
                          backgroundColor: Colors.white,
                          onClicked: () {
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          }),
                    ],
                  )
                ],
              ),
            ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: const Text("Timer"),
        ),
        backgroundColor: Colors.teal[300],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildTime(),
              SizedBox(
                height: 80,
              ),
              buildButtons(classesString != null),
              buildClassBox(classesString != null),
            ],
          ),
        ),
      );

  Widget buildTime() {
    transformClasses();
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      buildTimeCard(time: hours, header: 'HOURS'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: minutes, header: 'MINUTES'),
      SizedBox(
        width: 8,
      ),
      buildTimeCard(time: seconds, header: 'SECONDS'),
    ]);
  }

  Widget buildTimeCard({required String time, required String header}) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Text(
              time,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 72),
            ),
          ),
          SizedBox(
            height: 24,
          ),
          Text(header, style: TextStyle(color: Colors.black45)),
        ],
      );

  Widget buildButtons(bool hasClasses) {
    final isRunning = timer == null ? false : timer!.isActive;
    //final isCompleted = duration.inSeconds == 0;
    if (!hasClasses)
      return Container(
        color: Colors.purple[300],
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.center,
        child: const Text(
          "No classes found.",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    return isRunning
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                  text: 'PAUSE',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(resets: false);
                    }
                  }),
              SizedBox(
                width: 12,
              ),
              ButtonWidget(text: "STOP", onClicked: stopTimer),
            ],
          )
        : ButtonWidget(
            text: "START",
            color: Colors.black,
            backgroundColor: Colors.white,
            onClicked: () {
              startTimer();
            });
  }

  Widget buildClassBox(bool hasClass) {
    if (!hasClass) {
      return Container(
        color: Colors.purple[300],
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        alignment: Alignment.center,
        child: const Text(
          "Please go to classes page and add class first.",
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      );
    }
    _curClass = classesString!.first;
    return classesString == null
        ? Container(
            color: Colors.purple[300],
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            alignment: Alignment.center,
            child: const Text(
              "No classes found.",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          )
        : DropdownButton<String>(
            value: _curClass,
            icon: const Icon(Icons.expand_more),
            items: classesString?.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _curClass = value!;
              });
            });
  }
}

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Color backgroundColor;
  final VoidCallback onClicked;

  const ButtonWidget(
      {Key? key,
      required this.text,
      required this.onClicked,
      this.color = Colors.white,
      this.backgroundColor = Colors.black})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: backgroundColor,
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16)),
      onPressed: onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: color),
      ));
}
