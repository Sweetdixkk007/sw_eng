import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final formKey = GlobalKey<FormState>();
  final picker =ImagePicker();
  File ? _selectedImage;

  
  

  Future uploadImage()async{
    var uri = Uri.parse("http://10.0.2.2/flutter_login/register.php");
    var request =  http.MultipartRequest('POST',uri);
    var pic = await http.MultipartFile.fromPath("image", _selectedImage!.path);
    request.files.add(pic);
    var response = await request.send();

    if(response.statusCode == 200){
      print('image Uploaded');
    }else{
      print('Image Not Uploaded');
    }
    
  }

  
  Future choiceImage()async{
     final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
     if(returnedImage == null) return;
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
                    "แก้ไขโปรไฟล์ของคุณ",
                    style: GoogleFonts.dmSans(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 3, 4, 90)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    icon: Icon(Icons.camera),
                    onPressed:(){
                      choiceImage();
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _selectedImage != null ? CircleAvatar(backgroundImage: FileImage(_selectedImage!), radius: 50.0,) : const Text("กรุณาเลือกรูปภาพ"),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'กรุณากรอกชื่อ',
                      ),
                      validator: (val){
                        if (val!.isEmpty){
                          return 'Empty';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 350,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Row(children: [
                            Transform.scale(
                              scale: 0.7,
                            ),
                            const SizedBox(
                              width: 0,
                            ),
                          ]),
                        ),
                      ],
                    ),
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

                        if(pass){
                          uploadImage();
                        }
                      },
                      child: const Text(
                        'บันทึกการเปลี่ยนแปลง',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      
        ]),
        ),
      )); // This trailing comma makes auto-formatting nicer for build methods.
  }
}