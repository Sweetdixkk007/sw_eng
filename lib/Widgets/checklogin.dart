import 'package:flutter/material.dart';
import 'package:jobspot/Screens/Home.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:jobspot/Widgets/user.dart';

class check_login extends StatefulWidget {
  const check_login({Key? key}): super(key: key);
  @override
  State<check_login> createState() => _check_loginState();
}
// ignore: camel_case_types
class _check_loginState extends State<check_login> {
  Future checklogin() async { 
    bool? signin = await User.getsignin();
      print(signin);
  
    if(signin == false||signin == null) {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>const Login()));
    } 
    else {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>const HomeScreen()));  
    }
  }
  @override
  void initState(){
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}