import 'package:flutter/material.dart';
import 'package:healthone/mentalhealth_folder/mental_data.dart';
import 'mentalglobal.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;

class MentalHealthPage extends StatelessWidget {

  //stress data
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

  //mood data
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

  int exerciseDuration = 0;
  int meditationDuration = 0;

  //Exercise
    Future getExerciseDuration() async{

    var url = Uri.parse(baseUrl + '/exercise');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET EXERCISE DURATION'");
    exerciseDuration = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

    Future getMeditationDuration() async{

    var url = Uri.parse(baseUrl + '/meditation');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET MEDITATION DURATION'");
    meditationDuration = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

  //Study
    int studyDuration = 0;

    Future getStudyDuration() async{

    var url = Uri.parse(baseUrl + '/activities');
    http.Response response = await http.get(
      url,
      headers: headers,
    );
    print("YOU ARE PINGING 'GET STUDY DURATION'");
    studyDuration = int.parse(response.body.toString());
    print(response.body);
    return response.body;
  }

    // @override
    // void initState(){
    // // super.initState();
    // getLowStress();
    // getRegularStress();
    // getHighStress();

    // getNegativeMood();
    // getNeutralMood();
    // getPositiveMood();

    // getMeditationDuration();
    // getStudyDuration();

    // getStudyDuration();
    // }

  @override
  Widget build(BuildContext context) {
    getLowStress();
    getRegularStress();
    getHighStress();

    getNegativeMood();
    getNeutralMood();
    getPositiveMood();

    getMeditationDuration();
    getExerciseDuration();

    getStudyDuration();

    return Scaffold(
      appBar: AppBar(title: Text('Mental Analysis'),centerTitle: true),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                // Text('Hello World', style: TextStyle(fontSize: 20),),
                Text('Weekly Mental Health Analysis', style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                Text('Your mood levels have been:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),


                Row(children:[Text('Negative: '), Text(negativeMood.toString(), style: TextStyle(color: Colors.blue[700]))]),
                Row(children:[Text('Neutral: '), Text(neutralMood.toString(), style: TextStyle(color: Colors.pink[400]))]),
                Row(children:[Text('Positive: ',), Text(positiveMood.toString(), style: TextStyle(color: Colors.purple[800]))]),

                Text(''),

                Text('Your stress levels have been:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(children:[Text("Low: "), Text(lowStress.toString(), style: TextStyle(color: Colors.green[700]))]),
                Row(children:[Text("Regular: "), Text(regularStress.toString(), style: TextStyle(color: Colors.yellow[700]))]),
                Row(children:[Text("High: "), Text(highStress.toString(), style: TextStyle(color: Colors.red[600]))]),

                Text(''),
                Text('Activity Duration:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(children:[Text("Exercise: "), Text(exerciseDuration.toString(), style: TextStyle(color: Colors.blue[800])), Text(" minutes")]),
                Row(children:[Text("Meditation: "), Text(meditationDuration.toString(), style: TextStyle(color: Colors.blue[800])), Text(" minutes")]),
                Row(children:[Text("Study: "), Text(studyDuration.toString(), style: TextStyle(color: Colors.blue[800])), Text(" minutes")]),

                // Text('This is Italic Text', style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),),
                // Text('This is Colored Text', style: TextStyle(fontSize: 20, color: Colors.pink),),
                // Text('Hello World Custom Fonts', style: TextStyle(fontSize: 20, fontFamily: 'Lacquer'),),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children:[Text(
                    "• You have meditated for " + meditationDuration.toString() + " minutes this week, which is " + ((meditationDuration.toDouble()/60)).toStringAsFixed(3) + " hours per week. If you want to reduce stress and feel more relaxed (if you think " + highStress.toString() + " exceeds the high stress you should be having), please meditate for a few more hours each day",
                  textAlign: TextAlign.justify,           
                  ),
                    Text(
                    "• You have exercised for " + exerciseDuration.toString() + " minutes this week, which is " + (exerciseDuration.toDouble()/60).toStringAsFixed(3) + " hours per week. Exercise has been proven to not only reduce stress and mood, but also improve your grades.",
                  textAlign: TextAlign.justify,           
                  ),
                  Text(
                    "• You have studied for " + studyDuration.toString() + " minutes this week, which is " + (studyDuration.toDouble()/60).toStringAsFixed(3) + " hours per week. If your study time has been reduced, please ensure that you are not feeling overwhelming stress (This week your high stress level is " + highStress.toString() + ") or emotions (Your negative emotion level this week is " + negativeMood.toString() + "). Exercising also helps with focus, so increase the frequency of your aerobic exercise as necessary.",
                  textAlign: TextAlign.justify,           
                  ),
                  ]
                  )
                )
                

              ],
            ),
          ),
        ],
      ),
    );
  }
}