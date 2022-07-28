import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'db_things.dart';
import 'meditation_tile.dart';
import 'meditation.dart';
import 'meditation_data.dart';


class PrintMeditations extends StatefulWidget{
  const PrintMeditations({Key? key, required this.meditater}) : super(key : key);
  final String meditater;
  @override
  _MeditationTypePageState createState() => _MeditationTypePageState();
}

class _MeditationTypePageState extends State<PrintMeditations>{
  List<Meditation>? meditations;

  getMeditations()async{
    //meditations = await DbThings.getMeditations();
    meditations = await DbThings.getMeditationsByType(widget.meditater);
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
    )//scaffold
        :Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: Text(
          '${Provider.of<MeditationData>(context).meditations.length} meditations to choose from',
        ),//title
        centerTitle: true,
      ),//appbar
      body: Container(
        color: Colors.teal[900],
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
                  );//meditationtile
                });//itembuilder

          },//builder
        ),//consumer<meditationdata>
      ),//container
    );//scaffold
  }//build
}//class