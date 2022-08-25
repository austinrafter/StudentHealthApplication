import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/meditation_data.dart';
import '../exercise_meditation_folder/exercise_for_given_time.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/daily_meditation_info.dart';


class MeditationInfoPage extends StatelessWidget {

  const MeditationInfoPage({Key? key}) : super(key: key);
  //static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MeditationData>(
      create: (context) => MeditationData(),
      child: Container(
        child: DailyMeditationInfo(),
      ),//MaterialApp
    );//ChangeNotifierProvider
  }//build
}