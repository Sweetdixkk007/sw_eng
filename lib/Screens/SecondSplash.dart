import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobspot/Screens/Home.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecondSplash extends StatefulWidget {
  const SecondSplash({Key? key});

  @override
  State<SecondSplash> createState() => _SecondSplashState();
}

class _SecondSplashState extends State<SecondSplash> {
  Future<void> noLogin() async {
    late SharedPreferences pref;
    pref = await SharedPreferences.getInstance();
    var name0 = ("Guest");
    var image0 = ("guestprofile.jpg");
    print(name0);

    await pref.setString('username', name0);
    await pref.setString('pic', image0);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 247, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                ),
              ),
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
                          color: Color.fromARGB(255, 250, 162, 53),
                          fontSize: 25,
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
                          fontSize: 25,
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
                      Flexible(
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
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 250, 162, 53),
                            padding: EdgeInsets.symmetric(vertical: 15), // Adjust padding as needed
                          ),
                          child: Text(
                            "เข้าสู่ระบบ",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            noLogin();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 250, 162, 53),
                            padding: EdgeInsets.symmetric(vertical: 15), // Adjust padding as needed
                          ),
                          child: Text(
                            "ล็อกอินด้วย Guest",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
