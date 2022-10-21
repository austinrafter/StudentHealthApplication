import 'package:flutter/material.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'mentalglobal.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class MentalType extends StatefulWidget{

  @override
  _ChartTemplateState createState() => _ChartTemplateState();
}

class _ChartTemplateState extends State<MentalType> {
  static int lowStress = 0;
  static int regularStress = 0;
  static int highStress = 0;
  

  Future getLowStress() async{
    print("TESTING");
    var url = Uri.parse(baseUrl + '/getLowStress');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET LOW STRESS'");
    print(response.body);
    print(response.body.runtimeType);
    lowStress = int.parse(response.body.toString());
    print("THIS IS LOW STRESS AS AN INT: ");
    print(lowStress);
    print(lowStress.runtimeType);
    return response.body;
  }

    Future getRegularStress() async{

    var url = Uri.parse(baseUrl + '/getRegularStress');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET REGULAR STRESS'");
    regularStress = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

    Future getHighStress() async{

    var url = Uri.parse(baseUrl + '/getHighStress');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET HIGH STRESS'");
    highStress = int.parse(response.body.toString());
    print(response.body);
    return response.body;
    }

  @override
  void initState(){
  super.initState();
  getLowStress();
  getRegularStress();
  getHighStress();
  }
  
  @override
  Widget build(BuildContext context) {
    final List<StressTimeline> listStress = [
      StressTimeline(stress: "Low", stressLevel: lowStress),
      StressTimeline(stress: "Regular", stressLevel: regularStress),
      StressTimeline(stress: "High", stressLevel: highStress),
    ];
    final green = charts.MaterialPalette.green.makeShades(2);
    final yellow = charts.MaterialPalette.yellow.makeShades(2);
    final red = charts.MaterialPalette.red.makeShades(2);
   
    List<charts.Series<StressTimeline, String>> timeline = [
      charts.Series(
        id: "StressGraph",
        data: listStress,
        //the x axis
        domainFn: (StressTimeline timeline, _) => timeline.stress,
        //the y axis
        measureFn: (StressTimeline timeline, _) => timeline.stressLevel,
        colorFn: (StressTimeline timeline, __) {
          switch (timeline.stress) {
            case "Low":
              {
                return green[1];
              }

            case "Regular":
              {
                return yellow[1];
              }

            default:
              {
                return red[1];
              }
          }
        }
      )
    ];

    return Scaffold(
      appBar: AppBar(title: Text("Mental Health Analysis")),
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
                      "Weekly Stress Count",
                    ),
                    Expanded(
                      child: charts.BarChart(timeline, animate: true),
                    ),
                    Text(
                      "Stress Level",
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

class StressTimeline {
  final String stress;
  final int stressLevel;

  StressTimeline({
    required this.stress,
    required this.stressLevel,
  });
}