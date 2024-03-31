import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:page_transition/page_transition.dart';

class SecondSplash extends StatelessWidget {
  const SecondSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 239, 247, 255),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 250, 162, 53),
        child: const Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: const Login()));
        },
      ),
      body: Column(children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("lib/assets/sp.png"),
            filterQuality: FilterQuality.high,
          )),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "ยินดีต้อนรับ!!!",
                    style: GoogleFonts.dmSans(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "เพราะการกิน คือเรื่องสำคัญ",
                    style: GoogleFonts.dmSans(
                  
                      color: const Color.fromARGB(255, 250, 162, 53),
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "พบกับสูตรอาหารมากมาย!",
                    style: GoogleFonts.dmSans(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "มาเป็นส่วนหนึ่งกับพวกเราได้ในคอมมูนิตี้",
                      style: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }
}
