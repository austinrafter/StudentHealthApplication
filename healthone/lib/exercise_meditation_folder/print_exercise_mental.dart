import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'exercise_mental_tile.dart';
import 'exercise_mental_comparison.dart';
import 'exercise_data.dart';
import 'dart:io';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';
import '../analysis_folder/suggestion.dart';
import '../analysis_folder/suggestion_tile.dart';


class PrintExerciseMental extends StatefulWidget{
  const PrintExerciseMental({Key? key}) : super(key : key);

  @override
  _ExerciseMentalPageState createState() => _ExerciseMentalPageState();
}

class _ExerciseMentalPageState extends State<PrintExerciseMental>{
  List<ExerciseMentalComparison>? exerciseMentalComparisons;
  Suggestion? suggestionOne;
  Suggestion? suggestionTwo;

  getExercises()async{
    exerciseMentalComparisons = await DbThings.getExerciseMental();
    suggestionOne = await DbThings.getSuggestionForMoodExercise();
    suggestionTwo = await DbThings.getSuggestionForStressExercise();
    Provider.of<ExerciseData>(context, listen: false).exerciseMentalComparisons = exerciseMentalComparisons!;
    setState(() {});
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  @override
  void initState(){
    super.initState();
    getExercises();
  }

  @override
  Widget build(BuildContext context){
    return exerciseMentalComparisons == null?
    const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    )
        :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text(
          'Exercise and Mental Health'
        ),
        centerTitle: true,
        /*leading: GestureDetector(
          onTap: (
              ) { Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_circle_left,
          ),//Icon
        ),//leading

         */
      ),
      body: Container(
        color: Colors.teal[900],
        child: Column(
        children: [
          Text("Suggestions", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          Column(
            children:[
              Container(
                child: suggestionOne == null? Text('') : SuggestionTile(suggestion: suggestionOne),
              ),
              Container(
                child: suggestionTwo == null? Text('') : SuggestionTile(suggestion: suggestionTwo),
              ),
            ],
          ),
          Text("Daily Exercise And Mental Health Information", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
          Expanded(
    child: Consumer<ExerciseData>(
            builder: (context, exerciseData, child){
              return ListView.builder(
                  itemCount: exerciseData.exerciseMentalComparisons.length,
                  //gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2),
                  itemBuilder: (context, index) {
                    ExerciseMentalComparison exerciseMental = exerciseData.exerciseMentalComparisons[index];
                    return ExerciseMentalTile(
                        exerciseMental: exerciseMental,
                        exerciseData: exerciseData
                    );//ExerciseTile
                  });//itemBuilder
            },//builder
          ),//Consumer
          ),//Expanded

        ],//children
      ),//Stack
    ),
    );//Scaffold
  }//build
}//class