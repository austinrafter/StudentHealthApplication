import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'meditation_tile.dart';
import 'meditation.dart';
import 'meditation_data.dart';


class PrintMeditations extends StatefulWidget{
  const PrintMeditations({Key? key}) : super(key : key);

  @override
  _MeditationTypePageState createState() => _MeditationTypePageState();
}

class _MeditationTypePageState extends State<PrintMeditations>{
  List<Meditation>? meditations;

  getMeditations()async{
    meditations = await DbThings.getMeditations();
    Provider.of<MeditationData>(context, listen: false).meditations = meditations!;
    setState(() {});
  }

  @override
  void initState(){
    super.initState();
    getMeditations();
  }

  @override
  Widget build(BuildContext context){
    return meditations == null?
    const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        )
    )
        :Scaffold(
      appBar: AppBar(
        title: Text(
          '(${Provider.of<MeditationData>(context).meditations.length}) exercises to choose from',
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Consumer<MeditationData>(
          builder: (context, meditationData, child){
            return ListView.builder(
                itemCount: meditationData.meditations.length,
                itemBuilder: (context, index) {
                  Meditation meditation = meditationData.meditations[index];
                  return MeditationTile(
                      meditation: meditation,
                      meditationData: meditationData
                  );
                });

          },
        ),
      ),
    );
  }
}