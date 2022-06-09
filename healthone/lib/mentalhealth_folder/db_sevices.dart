import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:healthone/mentalhealth_folder/mood.dart';

import 'global.dart';

class DBServices{
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
}