import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_meditations.dart';
import '../exercise_meditation_folder/meditation_tile.dart';
import '../exercise_meditation_folder/meditation.dart';
import '../exercise_meditation_folder/meditation_data.dart';
import '../exercise_meditation_folder/perform_meditation.dart';



class MeditationTypePage extends StatelessWidget {
  const MeditationTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MeditationData>(
      create: (context) => MeditationData(),
      child: MaterialApp(
        title: "HealthOne",

        theme: ThemeData(
          primaryColor: Colors.teal[400],
        ),
        debugShowCheckedModeBanner: false,
        home: PerformMeditation(),
      ),

    );
  }
}
