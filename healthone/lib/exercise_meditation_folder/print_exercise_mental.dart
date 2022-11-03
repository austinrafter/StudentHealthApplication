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
  List<ExerciseMentalComparison>? exerciseMentalComparisons2;
  Suggestion? suggestionOne;
  Suggestion? suggestionTwo;

  Suggestion? suggestionThree;
  Suggestion? suggestionFour;

  Suggestion? suggestionFive;
  Suggestion? suggestionSix;


  getExercises()async{
    exerciseMentalComparisons = await DbThings.getExerciseMental();
    suggestionOne = await DbThings.getSuggestionForMoodExercise();
    suggestionTwo = await DbThings.getSuggestionForStressExercise();
    suggestionThree = await DbThings.getSuggestionForMoodMeditation();
    suggestionFour = await DbThings.getSuggestionForStressMeditation();
    suggestionFive = await DbThings.getSuggestionForStudyMeditation();
    suggestionSix = await DbThings.getSuggestionForStudyExercise();
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
          'Suggestions'
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
      body: ListView(
    children: <Widget>[
      Container(
        color: Colors.amber[600],
      child:
          Text("Exercise", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 20, ),),
      ),

              Container(
                child: suggestionOne == null? Text('') : SuggestionTile(suggestion: suggestionOne),
              ),
              Container(
                child: suggestionTwo == null? Text('') : SuggestionTile(suggestion: suggestionTwo),
              ),
              Container(
                child: suggestionSix == null? Text('') : SuggestionTile(suggestion: suggestionSix),
              ),
            Container(
              color: Colors.amber[600],
              child:
            Text("Meditation", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),),
            ),

                Container(
                  child: suggestionThree == null? Text('') : SuggestionTile(suggestion: suggestionThree),
                ),
                Container(
                  child: suggestionFour == null? Text('') : SuggestionTile(suggestion: suggestionFour),
                ),
                Container(
                  child: suggestionFive == null? Text('') : SuggestionTile(suggestion: suggestionFive),
                ),


        ],//children
      ),//Stack
    );//Scaffold
  }//build
}//class