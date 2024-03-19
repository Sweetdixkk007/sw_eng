import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jobspot/Screens/SecondSplash.dart';

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

    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const SecondSplash();
      }));
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
