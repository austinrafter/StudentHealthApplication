import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_db_services.dart';
import 'profile_tile.dart';
import 'student.dart';
import 'profile_data.dart';
import 'dart:io';


class PrintProfiles extends StatefulWidget{
  const PrintProfiles({Key? key}) : super(key : key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<PrintProfiles>{
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String userName = "";
  String userEmail = "";
  String userSchool = "";
  double userWeight = 0;
  List<Student>? students;

  getStudents()async{
    students = await ProfileDb.getStudents();
    Provider.of<ProfileData>(context, listen: false).students = students!;
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
    getStudents();
  }

  @override
  Widget build(BuildContext context){
    //if students is empty display the form for student input otherwise print the student info
    return students == null?
        /*
     Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal[900],
          title: Text(
          'Enter your user information',
          ),//Text
          centerTitle: true,
        ),//AppBar

        body: Container(
          child: Column(
            children:[
              TextFormField(
                  decoration: const InputDecoration(
                    icon: Icon(Icons.person),
                    hintText: 'What do you want your username to be?',
                    labelText: 'Username *',
                  ),
                onChanged: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  userName = value;
                  print(userName);
                },//onSaved
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your user name';
                  }
                  return null;
                },//validator
              ),//TextFormField
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.email),
                  hintText: 'What is your email?',
                  labelText: 'Email *',
                ),
                onChanged: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  print(value);
                  userEmail = value;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),//TextFormField
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.school),
                  hintText: 'What is the school you go to?',
                  labelText: 'School *',
                ),
                onChanged: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  userSchool = value;
                  print(userSchool);
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the name of your school';
                  }
                  return null;
                },
              ),//TextFormField
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.add_chart_outlined),
                  hintText: 'What is your current weight?',
                  labelText: 'Weight *',
                ),//InputDecoration
                onChanged: (String value) {
                  // This optional block of code can be used to run
                  // code when the user saves the form.
                  var enteredWeight = double.parse(value);
                  print(enteredWeight);
                  userWeight = enteredWeight;
                },//onChanged
                validator: (String? value) {
                  if (value == null || value.isEmpty || !isNumeric(value)) {
                    return 'Please enter your current weight';
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
                  if (userName.isNotEmpty && userEmail.isNotEmpty && userSchool.isNotEmpty && (userWeight > 0)) {
                    Provider.of<ProfileData>(context, listen: false)
                        .addStudent(userName,userEmail,userSchool,userWeight);
                  }
                  sleep(Duration(seconds:1));
                  setState(() => getStudents());

                },//onPressed
                child: const Text('Create profile'),
              ),//RaisedButton
            ],//children
          ),//Column
        ),//Container
    )//Scaffold

         */
    const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    )
        :Scaffold(
      appBar: AppBar(
        title: Text(
          '${Provider.of<ProfileData>(context).students.length} profiles set up',
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Consumer<ProfileData>(
            builder: (context, profileData, child){
              return ListView.builder(
                  itemCount: profileData.students.length,
                  itemBuilder: (context, index) {
                    Student student = profileData.students[index];
                    return ProfileTile(
                        student: student,
                        profileData: profileData
                    );//ExerciseTile
                  });//itemBuilder

            },//builder
          ),//Consumer
        ),//Container
          Container(
            child: students?.length != 0? Container(
              child: Text(""),
            ) : Container(
              child: Column(
                children:[
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What do you want your username to be?',
                      labelText: 'Username *',
                    ),
                    onChanged: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      userName = value;
                      print(userName);
                    },//onSaved
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your user name';
                      }
                      return null;
                    },//validator
                  ),//TextFormField
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'What is your email?',
                      labelText: 'Email *',
                    ),
                    onChanged: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      print(value);
                      userEmail = value;
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),//TextFormField
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.school),
                      hintText: 'What is the school you go to?',
                      labelText: 'School *',
                    ),
                    onChanged: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      userSchool = value;
                      print(userSchool);
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the name of your school';
                      }
                      return null;
                    },
                  ),//TextFormField
                  TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add_chart_outlined),
                      hintText: 'What is your current weight?',
                      labelText: 'Weight *',
                    ),//InputDecoration
                    onChanged: (String value) {
                      // This optional block of code can be used to run
                      // code when the user saves the form.
                      var enteredWeight = double.parse(value);
                      print(enteredWeight);
                      userWeight = enteredWeight;
                    },//onChanged
                    validator: (String? value) {
                      if (value == null || value.isEmpty || !isNumeric(value)) {
                        return 'Please enter your current weight';
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
                      if (userName.isNotEmpty && userEmail.isNotEmpty && userSchool.isNotEmpty && (userWeight > 0)) {
                        Provider.of<ProfileData>(context, listen: false)
                            .addStudent(userName,userEmail,userSchool,userWeight);
                      }
                      sleep(Duration(seconds:1));
                      getStudents();
                      setState(() => {});

                    },//onPressed
                    child: const Text('Create profile'),
                  ),//RaisedButton
                ],//children
              ),//Column
            )
          )
        ],//children
      ),//Stack
    );//Scaffold
  }//build
}//class