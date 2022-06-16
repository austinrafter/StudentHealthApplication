import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'exercise_tile.dart';
import 'exercise.dart';
import 'exercise_data.dart';


class PrintExercises extends StatefulWidget{
  const PrintExercises({Key? key}) : super(key : key);

  @override
  _ExerciseTypePageState createState() => _ExerciseTypePageState();
}

class _ExerciseTypePageState extends State<PrintExercises>{
  List<Exercise>? exercises;

  getExercises()async{
    exercises = await DbThings.getExercises();
    Provider.of<ExerciseData>(context, listen: false).exercises = exercises!;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getExercises();
  }

  @override
  Widget build(BuildContext context){
    return exercises == null?
    const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    )
        :Scaffold(
      appBar: AppBar(
        title: Text(
          '${Provider.of<ExerciseData>(context).exercises.length} exercises to choose from',
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer<ExerciseData>(
          builder: (context, exerciseData, child){
            return ListView.builder(
                itemCount: exerciseData.exercises.length,
                itemBuilder: (context, index) {
                  Exercise exercise = exerciseData.exercises[index];
                  return ExerciseTile(
                      exercise: exercise,
                      exerciseData: exerciseData
                  );
                });

          },
        ),
      ),
    );
  }
}