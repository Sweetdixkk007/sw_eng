// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobspot/Screens/Login.dart';
import 'package:jobspot/Screens/registersuccess.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController email = TextEditingController();

  final picker = ImagePicker();
  File? _selectedImage;

  bool? isChecked = false;
  bool isLoading = false;

  Future sign_up() async {
    var uri = Uri.parse("http://192.168.1.50/flutter_login/register.php");
    var request = http.MultipartRequest('POST', uri);

    // Add image file
    var pic = await http.MultipartFile.fromPath("image", _selectedImage!.path);
    request.files.add(pic);

    // Add name parameter
    request.fields['name'] = name.text;
    request.fields['email'] = email.text;
    request.fields['password'] = pass.text;

    var response = await request.send();

    if (response.statusCode == 200) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AlertDialogExampleApp()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Register()));
    }
  }

Future<bool> checkDuplicate() async {
  var uri = Uri.parse("http://192.168.1.50/flutter_login/check_duplicate.php");
  var request = http.MultipartRequest('POST', uri);
  request.fields['email'] = email.text;
  request.fields['name'] = name.text;

  var response = await request.send();

  if (response.statusCode == 200) {
    var jsonResponse = await response.stream.bytesToString();
    var result = json.decode(jsonResponse);
    if (result['error'] == true) {
      // Display error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("เกิดข้อผิดพลาด"),
            content: Text("ชื่อผู้ใช้หรืออีเมลถูกใช้แล้ว"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
      return false;
    } else {
      // No duplicates, proceed with sign up
      return true;
    }
  } else {
    // Error in API call
    print('Error checking duplicate');
    return false;
  }
}

void attemptSignUp() async {
  bool isDuplicate = await checkDuplicate();

  if (isDuplicate) {
    // No duplicates, proceed with sign up
    sign_up();
  }
}


  Future choiceImage() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 239, 247, 255),
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
      backgroundColor: Color(0xFFF5F5F5),
      body: Center(
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "กรุณาสมัครสมาชิก",
                    style: GoogleFonts.dmSans(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 3, 4, 90)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _selectedImage != null
                      ? CircleAvatar(
                          backgroundImage: FileImage(_selectedImage!),
                          radius: 50.0,
                        )
                      : Text(
                          "กรุณาเลือกรูปภาพ",
                          style: GoogleFonts.dmSans(
                              fontSize: 15,
                              color: const Color.fromARGB(255, 3, 4, 90)),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed: () {
                      choiceImage();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'กรุณากรอกชื่อ',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: name,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'กรุณากรอกอีเมลล์',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      controller: email,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'กรุณากรอกรหัสผ่าน',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        }
                        return null;
                      },
                      controller: pass,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'กรุณากรอกรหัสผ่านอีกครั้ง',
                      ),
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Empty';
                        } else if (val != pass.text) {
                          return 'password not match';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 3, 4, 90),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onPressed: () {
                        bool pass = formKey.currentState!.validate();

                        if (pass) {
                          attemptSignUp();
                        }
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account yet? ",
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: const Color.fromARGB(255, 4, 6, 126),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "Sign In",
                          style: GoogleFonts.dmSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: Colors.amber[700],
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}