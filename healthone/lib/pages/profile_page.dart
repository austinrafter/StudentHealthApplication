import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../profile/print_profiles.dart';
import '../profile/profile_tile.dart';
import '../profile/student.dart';
import '../profile/profile_data.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileData>(
      create: (context) => ProfileData(),
      child: MaterialApp(
        title: "HealthOne",

        theme: ThemeData(
          primaryColor: Colors.teal[400],
        ),
        debugShowCheckedModeBanner: false,
        home: PrintProfiles(),
      ),

    );
  }
}
