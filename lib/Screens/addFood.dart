import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobspot/Screens/addIngredients.dart';

class addFood extends StatefulWidget {
  const addFood({Key? key}) : super(key: key);

  @override
  State<addFood> createState() => _addFoodState();
}

class _addFoodState extends State<addFood> {
  // Define controllers for text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController instController = TextEditingController();

  final picker = ImagePicker();
  File? _selectedImage;

  // Function to choose an image from the gallery
  Future choiceImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) return;
    setState(() {
      _selectedImage = File(pickedImage.path);
    });
  }

  // Function to validate if all text fields are filled
  bool validateFields() {
    return nameController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        instController.text.isNotEmpty &&
        _selectedImage != null;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 162, 53),

          title: Text(
            'Add Food',
            style: GoogleFonts.anuphan(
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            // Only navigate to the next screen if all fields are filled
            IconButton(
              onPressed: () {
                if (validateFields()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => addIngr(
                        foodname: nameController.text,
                        description: descController.text,
                        instruction: instController.text,
                        selectedImage: _selectedImage!,
                      ),
                    ),
                  );
                } else {
                  // Show a dialog or snackbar to inform the user to fill all fields
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Please fill all fields and select an image.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: const Icon(Icons.check),
            ),
          ],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    "กรุณากรอกรายการอาหาร",
                    style: GoogleFonts.anuphan(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 3, 4, 90),
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Text field for food name
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "กรุณาใส่ชื่ออาหาร",
                      hintStyle: GoogleFonts.anuphan(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text field for food description
                  TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      hintText: "กรุณาใส่คำอธิบายอาหาร",
                      hintStyle: GoogleFonts.anuphan(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Text field for food instruction
                  TextField(
                    minLines: 5,
                    maxLines: 10,
                    controller: instController,
                    decoration: InputDecoration(
                      hintText: "กรุณาใส่ขั้นตอนการทำอาหาร",
                      hintStyle: GoogleFonts.anuphan(),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _selectedImage != null
                      ? GestureDetector(
                          onTap: () {
                            choiceImage();
                          },
                          child: Container(
                            width: 250,
                            height: 250,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: FileImage(_selectedImage!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      : Container(
                          width: 250,
                          height: 250,
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: const Icon(Icons.add_photo_alternate_rounded,
                                size: 100), // Adjust the size as needed
                            onPressed: () {
                              choiceImage();
                            },
                          ),
                        ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
}
