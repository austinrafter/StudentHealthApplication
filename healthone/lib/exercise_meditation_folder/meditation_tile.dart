import 'package:flutter/material.dart';
import '../exercise_meditation_folder/meditation.dart';
import '../exercise_meditation_folder/meditation_data.dart';

class MeditationTile extends StatelessWidget{
  final Meditation meditation;
  final MeditationData meditationData;

  const MeditationTile({Key? key, required this.meditation, required this.meditationData}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      child: ListTile(
        leading: Text(meditation.meditation_type,),
        title: Text(
          meditation.meditation_name,
        ),

      ),
    );
  }
}