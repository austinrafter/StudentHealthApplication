import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/print_exercises.dart';
import '../exercise_meditation_folder/meditation_tile.dart';
import '../exercise_meditation_folder/meditation.dart';
import '../exercise_meditation_folder/meditation_data.dart';
import '../exercise_meditation_folder/perform_meditation.dart';
import '../exercise_meditation_folder/print_meditations.dart';



class MeditationSoundPage extends StatelessWidget {
  final Meditation meditation;
  final String meditationname;
  final String meditationtype;
  final String audiolink;
  final String imagelink;
  const MeditationSoundPage({Key? key, required this.meditation, required this.meditationname, required this.meditationtype, required this.audiolink, required this.imagelink}) : super(key : key);
  static const routeName = '/passArguments';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MeditationData>(
      create: (context) => MeditationData(),
      child: Container(
        child: PerformMeditation(meditation: meditation, meditationname:meditationname, meditationtype:meditationtype, audiolink:audiolink, imagelink:imagelink),
      ),//Container

    );//ChangeNotifierProvider
  }
}