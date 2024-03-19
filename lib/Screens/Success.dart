import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 239, 247, 255),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 239, 247, 255),
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 80,
          ),
          Text(
            "Successfully",
            style: GoogleFonts.dmSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 3, 4, 90)),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: Text(
              "123 kuy",
              style: GoogleFonts.dmSans(
                  fontSize: 10,
                  fontWeight: FontWeight.w300,
                  color: const Color.fromARGB(255, 3, 4, 90)),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/assets/success_vector.png"),
              filterQuality: FilterQuality.high,
            )),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 4, 6, 126),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "CONTINUE",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 207, 207, 255),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "BACK TO LOGIN",
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
