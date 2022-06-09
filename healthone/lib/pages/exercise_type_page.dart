import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exercise_meditation_folder/db_things.dart';
import '../exercise_meditation_folder/exercise_tile.dart';
import '../exercise_meditation_folder/exercise.dart';
import '../exercise_meditation_folder/exercise_data.dart';


class ExerciseTypePage extends StatefulWidget{
  const ExerciseTypePage({Key? key}) : super(key : key);

  @override
  _ExerciseTypePageState createState() => _ExerciseTypePageState();
}

class _ExerciseTypePageState extends State<ExerciseTypePage>{
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
    return exercises == null
      ? const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          )
        )
      :Scaffold(
      appBar: AppBar(
        title: Text(
            '(${Provider.of<ExerciseData>(context).exercises.length}) exercises to choose from',
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
/*
class ExerciseTypePage extends StatelessWidget{
  const ExerciseTypePage({Key key, this.exerciseName, this.exerciseType, this.metabolicEquivalentScore}) : super(key: key);

  // This widget is the root of your application.
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Change
  }

 */

    /*
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        title: const Text("Exercise Page"),
      ),

      body: Container(
        padding: EdgeInsets.fromLTRB(10,10,10,0),
        height: 700,
        width: double.maxFinite,

        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: physicalData.length,
                itemBuilder: (context, index){
                  return Container(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    height: 220,
                    width: double.maxFinite,
                    child: Card(
                      elevation: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 2.0,
                            ),
                          ),

                        ),
                        child: Padding(
                          padding: EdgeInsets.all(7),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>  const ExerciseTypePage()),
                              );
                            },
                            child:Card(
                              color: Colors.teal[700],
                              child: Stack(
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      width: 200,
                                      height: 500,
                                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.topCenter,
                                          colors: <Color>[
                                            Colors.black.withAlpha(0),
                                            Colors.black12,
                                            Colors.black45
                                          ],
                                        ),
                                      ),
                                      child: Column(
                                          children: <Widget>[
                                            Row(
                                                children: <Widget>[
                                                  PhysicalItemPageName(physicalData[index]),
                                                ]
                                            )
                                          ]


                                      ),


                                    ),
                                  ),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),

      ),

    );
  }
}

     */