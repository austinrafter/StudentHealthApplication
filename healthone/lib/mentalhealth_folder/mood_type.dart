import 'package:flutter/material.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'mentalglobal.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class MoodType extends StatefulWidget{

  @override
  _ChartTemplateState createState() => _ChartTemplateState();
}

class _ChartTemplateState extends State<MoodType> {
  static int negativeMood = 0;
  static int neutralMood = 0;
  static int positiveMood = 0;
  
    Future getNegativeMood() async{

    var url = Uri.parse(baseUrl + '/getNegativeMood');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET NEGATIVE MOOD'");
    negativeMood = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

  Future getNeutralMood() async{

    var url = Uri.parse(baseUrl + '/getNeutralMood');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET NEUTRAL MOOD'");
    neutralMood = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

  Future getPositiveMood() async{

    var url = Uri.parse(baseUrl + '/getPositiveMood');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET POSITIVE MOOD'");
    positiveMood = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

  @override
  void initState(){
  super.initState();
  getNegativeMood();
  getNeutralMood();
  getPositiveMood();
  }
  
  @override
  Widget build(BuildContext context) {
    final List<MoodTimeline> listStress = [
      MoodTimeline(mood: "Negative", moodLevel: negativeMood),
      MoodTimeline(mood: "Neutral", moodLevel: neutralMood),
      MoodTimeline(mood: "Positive", moodLevel: positiveMood),
    ];
    final blue = charts.MaterialPalette.blue.makeShades(2);
    final pink = charts.MaterialPalette.pink.makeShades(2);
    final purple = charts.MaterialPalette.purple.makeShades(2);
   
    List<charts.Series<MoodTimeline, String>> timeline = [
      charts.Series(
        id: "MoodGraph",
        data: listStress,
        //the x axis
        domainFn: (MoodTimeline timeline, _) => timeline.mood,
        //the y axis
        measureFn: (MoodTimeline timeline, _) => timeline.moodLevel,
        colorFn: (MoodTimeline timeline, __) {
          switch (timeline.mood) {
            case "Negative":
              {
                return blue[1];
              }

            case "Neutral":
              {
                return pink[1];
              }

            default:
              {
                return purple[1];
              }
          }
        }
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Mood Analysis"), centerTitle: true),
      body: Center(
          child: Container(
            height: 400,
            padding: EdgeInsets.all(20),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Weekly Mood Count",
                    ),
                    Expanded(
                      child: charts.BarChart(timeline, animate: true),
                    ),
                    Text(
                      "Mood Level",
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}

class MoodTimeline {
  final String mood;
  final int moodLevel;

  MoodTimeline({
    required this.mood,
    required this.moodLevel,
  });
}