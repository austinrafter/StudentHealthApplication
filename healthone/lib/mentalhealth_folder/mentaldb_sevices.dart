import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:healthone/mentalhealth_folder/mood.dart';

import 'mentalglobal.dart';

class DBServices{
  static Future<Mood> addStressMood(String userName, String mood, String stress, String month, String day, String year) async{
    Map data = {
      "userName": userName,
      "mood": mood,
      "stress": stress,
      "month": month,
      "day": day,
      "year": year,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/stressmood');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);

    Mood m = Mood.fromMap(responseMap);
    return m;
  }

  static Future<Mood> addMood(String userName, String mood, String month, String day, String year) async{
    Map data = {
      "userName": userName,
      "mood": mood,
      "month": month,
      "day": day,
      "year": year,
    };

    var body = json.encode(data);
    var url = Uri.parse(baseUrl + '/updatemood');

    http.Response response = await http.post(
      url,
      headers: headers,
      body: body,
    );
    print(response.body);
    Map responseMap = jsonDecode(response.body);

    Mood m = Mood.fromMap(responseMap);
    return m;
  }

  static Future<List<Mood>> getMood() async{
    var url = Uri.parse(baseUrl + '/datamood');
    
    http.Response response = await http.get(
      url,
      headers:headers,
    );
    print(response.body);
    List responseList = jsonDecode(response.body);
    List<Mood> moods = [];

    for(Map moodMap in responseList){
      Mood mood = Mood.fromMap(moodMap);
      moods.add(mood);
    }
    return moods;

  }

  static Future<http.Response> updateMood(int id) async{
    var url = Uri.parse(baseUrl + '/updatemood/$id');

    http.Response response = await http.put(
      url,
      headers:headers,
    );
    print(response.body);
    return response;
  }

  static Future<http.Response> deleteMood(int id) async{

    var url = Uri.parse(baseUrl + '/deletemood/$id');
    http.Response response = await http.delete(
      url,
      headers: headers,
    );
    print(response.body);
    return response;
  }

//Get stress here

  // static Future<http.Response> getRegularStress() async{

  //   var url = Uri.parse(baseUrl + '/getRegularStress');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET REGULAR STRESS'");
  //   print(response.body);
  //   return response;
  // }

  //   static Future<http.Response> getHighStress() async{

  //   var url = Uri.parse(baseUrl + '/getHighStress');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET HIGH STRESS'");
  //   print(response.body);
  //   return response;
  // }

  // static Future<String> getLowStress() async{

  //   var url = Uri.parse(baseUrl + '/getLowStress');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET LOW STRESS'");
  //   print(response.body);
  //   return response.body;
  // }

//Getting mood
  // static Future<http.Response> getNegativeMood() async{

  //   var url = Uri.parse(baseUrl + '/getNegativeMood');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET REGULAR STRESS'");
  //   print(response.body);
  //   return response;
  // }

  // static Future<http.Response> getNeutralMood() async{

  //   var url = Uri.parse(baseUrl + '/getNeutralMood');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET REGULAR STRESS'");
  //   print(response.body);
  //   return response;
  // }

  // static Future<http.Response> getPositiveMood() async{

  //   var url = Uri.parse(baseUrl + '/getPositiveMood');
  //   http.Response response = await http.get(
  //     url,
  //     headers: headers,
  //   );
  //   print("YOU ARE PINGING 'GET REGULAR STRESS'");
  //   print(response.body);
  //   return response;
  // }

}