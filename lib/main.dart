import 'package:flutter/material.dart';
import 'package:jobspot/Screens/SecondSplash.dart';
import 'package:jobspot/Screens/Splash.dart';
import 'package:jobspot/Widgets/checklogin.dart';

void main() {
  runApp(const JobSpot());
}

class JobSpot extends StatefulWidget {
  const JobSpot({Key? key}) : super(key: key);

  @override
  State<JobSpot> createState() => _JobSpotState();
}

class _JobSpotState extends State<JobSpot> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: SecondSplash(),

    );
  }
}
