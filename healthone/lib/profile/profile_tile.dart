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
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: ListTile(
                title: Text(
                  student.username,
                ),//Text
                subtitle: Text(student.school,),
                trailing: Text(
                  student.weight.toString(),
                ),//Text
              ),//ListTile
            ),//Card
          ],//stack children
        ),//Stack
    );//Container
  }//build

}//class

