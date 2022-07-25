import 'package:flutter/material.dart';
import '../profile/student.dart';
import '../profile/profile_data.dart';



class ProfileTile extends StatelessWidget{
  final Student student;
  final ProfileData profileData;

  const ProfileTile({Key? key, required this.student, required this.profileData,}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child: Stack(
          children: [
            Card(
              color: Colors.teal[700],
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.teal.shade700,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: ListTile(
                title: Text(
                  student.username,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,),
                ),//Text
                subtitle: Text(
                  student.school,
                  style: TextStyle(fontStyle: FontStyle.italic,
                      color: Colors.white,),
                ),
                trailing: Text(
                  student.weight.toString(),
                  style: TextStyle(fontStyle: FontStyle.italic,
                      color: Colors.white,),
                ),//Text
              ),//ListTile
            ),//Card
          ],//stack children
        ),//Stack
    );//Container
  }//build

}//class

