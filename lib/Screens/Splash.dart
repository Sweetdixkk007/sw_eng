import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobspot/Screens/Home.dart';
import 'package:jobspot/Screens/SecondSplash.dart';
import 'package:jobspot/Widgets/user.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () async {bool? signin = await User.getsignin();;
      if (signin == false || signin == null){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const SecondSplash();
      }));}
      else if(signin == true){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 162, 53),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("lib/assets/icon.png"),
                    filterQuality: FilterQuality.high)),
          ),
        ]),
      ),
    );
  }
}
