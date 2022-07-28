import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'exercise_tile.dart';
import 'exercise.dart';
import 'exercise_data.dart';
import 'dart:io';
import '../profile/student.dart';
import '../profile/profile_data.dart';
import '../profile/profile_db_services.dart';


class PrintExercises extends StatefulWidget{
  const PrintExercises({Key? key, required this.exerciser}) : super(key : key);
  final String exerciser;

  @override
  _ExerciseTypePageState createState() => _ExerciseTypePageState();
}

class _ExerciseTypePageState extends State<PrintExercises>{
  List<Exercise>? exercises;
  String exercisename = "";
  String exercisetype = "";
  double metabolicequivalentscore = 0;
  String exerciseimage = "";

  getExercises()async{
    //exercises = await DbThings.getExercises();
    exercises = await DbThings.getExercisesByType(widget.exerciser);
    Provider.of<ExerciseData>(context, listen: false).exercises = exercises!;
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
    return exercises == null?
    const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    )
        :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text(
          '${Provider.of<ExerciseData>(context).exercises.length} exercises to choose from',
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
      body: Stack(
        children: [Container(
        color: Colors.teal[900],
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
                  );//ExerciseTile
                });//itemBuilder

          },//builder
        ),//Consumer
      ),//Container
          Align(
            alignment: Alignment.bottomLeft,
            child: RaisedButton(
              onPressed: () => showDialog<String> (

                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Metabolic Equivalence"),
                  content: Text("Metabolic Equivalent is the oxygen consumed in your body while performing an exercise. We use this to determine the calories you burn with each exercise. The higher the MET's the more calories you burn per minute."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },//onPressed
                      child: Text("Ok"),
                    ),//FlatButton
                  ],//actions
                ),//AlertDialog
              ),//onPressed
              child: const Icon(Icons.question_mark),
              color: Colors.teal[400],
              textColor: Colors.white,
              elevation: 5,
            ),//RaisedButton
          ),//Align
          Align(
            alignment: Alignment.bottomRight,
            child: RaisedButton(
              onPressed: () => showDialog<String> (

                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("Add a new exercise"),
                  content: Column(
                    children:[
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'What is the name of the exercise?',
                          labelText: 'Exercise Name *',
                        ),
                        onChanged: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                          exercisename = value;
                          print(exercisename);
                        },//onSaved
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the exercise name';
                          }
                          return null;
                        },//validator
                      ),//TextFormField
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.add_chart_outlined),
                          hintText: 'What is the projected MET of this exercise?',
                          labelText: 'MET *',
                        ),//InputDecoration
                        onChanged: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                          var enteredWeight = double.parse(value);
                          print(enteredWeight);
                          metabolicequivalentscore = enteredWeight;
                        },//onChanged
                        validator: (String? value) {
                          if (value == null || value.isEmpty || !isNumeric(value)) {
                            return 'Please enter the MET of the exercise';
                          }
                          return null;
                        },//validator
                      ),//TextFormField
                      TextFormField(
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          hintText: 'Provide a link to an online .gif or .jpg that matches your entered exercise to be shown.',
                          labelText: 'Exercise Image Link *',
                        ),
                        onChanged: (String value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                          exerciseimage = value;
                          print(exerciseimage);
                        },//onSaved
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a link to an online .gif or .jpg that matches your entered exercise';
                          }
                          return null;
                        },//validator
                      ),//TextFormField
                      const SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        //     disabledColor: Colors.red,
                        // disabledTextColor: Colors.black,
                        padding: const EdgeInsets.all(20),
                        textColor: Colors.white,
                        color: Colors.teal[400],
                        onPressed: () {
                          if (exercisename.isNotEmpty  && (metabolicequivalentscore > 0) && exerciseimage.isNotEmpty) {
                            Provider.of<ExerciseData>(context, listen: false)
                                .addExercise(exercisename,widget.exerciser,metabolicequivalentscore, exerciseimage);
                          }
                          sleep(Duration(seconds:1));
                          setState(() => {});
                          Navigator.of(ctx).pop();

                        },//onPressed
                        child: const Text('Create profile'),
                      ),//RaisedButton
                    ],//children
                  ),//Column

                ),//AlertDialog
              ),//onPressed
              child: const Icon(Icons.add_box,),
              color: Colors.teal[400],
              textColor: Colors.white,
              elevation: 5,
            ),//RaisedButton
          ),//Align
    ],//children
    ),//Stack
    );//Scaffold
  }//build
}//class