import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobspot/Screens/Ecom.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:jobspot/Screens/ProfileSetting.dart';
import 'package:jobspot/Widgets/user.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

@override
class _NavBarState extends State<NavBar> {
  late SharedPreferences pref;
  late String username = "";
  late String id = "";
  String pic = "";
  
  

  Future<void> dud() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString('username').toString();

      pic = pref.getString('pic').toString();
  
    });

  }
  
  Future logout() async {
    await User.setsignin(false);
    id = "";
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Login()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dud();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage(
                'http://10.0.2.2/flutter_login/upload/$pic'),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            child: Text(
              username,
              style: GoogleFonts.dmSans(
                color: const Color.fromARGB(255, 3, 4, 90),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Account"),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: ProfilePage()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("ffff"),
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: const Ecom()));
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListTile(
                    leading: const Icon(Icons.headset_mic_rounded),
                    title: const Text("Support"),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(children: [
              ListTile(
                title: const Text(
                  "Sign Out",
                  textAlign: TextAlign.end,
                ),
                trailing: const Icon(Icons.subdirectory_arrow_right_sharp),
                onTap: () {       
                  logout();
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
