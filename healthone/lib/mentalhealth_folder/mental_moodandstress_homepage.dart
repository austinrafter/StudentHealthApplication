import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:healthone/mentalhealth_folder/mental_events_example.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MentalHomePage()));
}

class MentalHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HealthOne",
      theme: ThemeData(
        primaryColor: Colors.teal[400],
      ),
      debugShowCheckedModeBanner: false,
      home: TableEventsExample(),
    );
  }
}

// class MentalHomePage extends StatefulWidget{
//  MentalHomePage({Key? key}) : super(key: key);

//   @override
//   _MentalHomePageState createState() => _MentalHomePageState();
// }

// class _MentalHomePageState extends State<MentalHomePage>{

// List<Mood>? moods;

// getMood()async{

//   moods = await DBServices.getMood();
//   Provider.of<MentalData>(context, listen: false).moods = moods!;
//   setState(() {
    
//   });
// }

// @override
// void initState(){
//   super.initState();
//   getMood();
// }

// class StartPage extends StatefulWidget {
//   @override
//   _StartPageState createState() => _StartPageState();
// }

// class _StartPageState extends State<StartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Mental Health Tracker'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               child: Text('Events'),
//               onPressed: () => Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => TableEventsExample()),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: "Mental Health Page",
  //     theme: ThemeData(
  //       primaryColor: Colors.teal[400],
  //     ),
  //     debugShowCheckedModeBanner: false,
  //     home: Calendar(),
  //   );

//     return Scaffold(
//     backgroundColor: Colors.teal[400],
//     appBar: AppBar(
//       title: const Text("Mental Health Page"),
//       backgroundColor: Colors.teal[600],
//     ),
//     body: Center(
//         child: Text(
//           "Mental Health Page",
//           style: TextStyle(fontSize:50),
//         ),
//       ),
//     );
//   }
// }

