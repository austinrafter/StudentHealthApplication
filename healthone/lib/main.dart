import 'package:flutter/material.dart';
import 'mentalhealth_folder/mental_page.dart';
import 'physicalHealthPages/physical_page.dart';
import 'physicalHealthPages/profile_page.dart';
import 'study_habits_folder/study_page.dart';
import 'analysis_folder/analysis_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthOne',
      theme: ThemeData(
      primarySwatch: Colors.teal,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget{
  
 HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
int currentIndex = 0;

final screens = [
  PhysicalPage(),
  MentalPage(),
  StudyPage(),
  AnalysisPage(),
  ProfilePage(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.teal[900],

      //Can't figure out how to add gradient, need to use body for bottom nav bar
      
    //Code tutorial for gradient bg credit: https://www.digitalocean.com/community/tutorials/flutter-flutter-gradient
    //https://api.flutter.dev/flutter/painting/LinearGradient-class.html

      // appBar: AppBar(
        // backgroundColor: Colors.teal,
        // title: Center(
        //   child: Text('HealthOne'),
        //   ),
      // ),

      // body: Container(
        // child: Container(
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       begin: Alignment(-1, -1),
        //       end: Alignment(0.8, 1),
        //       colors: [
        //         Colors.teal[900]!,
        //         Colors.green[300]!,
        //       ],
        //       tileMode: TileMode.mirror,
        //     )
        //   ),
        // ),
      // ),

      body: screens[currentIndex],
      //Code tutorial for navbar selection: https://www.youtube.com/watch?v=xoKqQjSDZ60&ab_channel=JohannesMilke
      //https://www.youtube.com/watch?v=elLkVWt7gRM&ab_channel=ProgrammingAddict
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: "Physical",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.balance_outlined),
            label: "Mental",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: "Study",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books_outlined),
            label: "Analysis",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

// class HomeBG extends StatelessWidget{
//     const HomeBG({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//         gradient: LinearGradient(
//         begin: Alignment(-1, -1),
//         end: Alignment(0.8, 1),
//         colors: [
//           Colors.teal[900]!,
//           Colors.green[300]!,
//         ],
//         tileMode: TileMode.mirror,
//         )
//       ),
//     );
//   }
// }