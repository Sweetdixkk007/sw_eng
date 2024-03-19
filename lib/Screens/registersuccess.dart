import 'package:flutter/material.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:jobspot/Screens/Register.dart';

/// Flutter code sample for [AlertDialog].

void main() => runApp(const AlertDialogExampleApp());

class AlertDialogExampleApp extends StatelessWidget {
  const AlertDialogExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const Center(
          child: DialogExample(),
        ),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  const DialogExample({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ล็อกอิน',
                        style: TextStyle(
                          color: Colors.white,
                        ),
          ),
          content: const Text('ต้องการไปที่หน้าล็อกอินหรือไม่',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register())),
              child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login())),
              child: const Text('OK',
                        style: TextStyle(
                          color: Colors.white,
                        ),),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 4, 6, 126),
        ),
      ),
      
      child: const Text('             สำเร็จ!!!\nกรุณาล็อกอินเข้าสู่ระบบ',
      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 3, 4, 90),
                          fontWeight: FontWeight.bold,
                        ),),
    );
  }
}