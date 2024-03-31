import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobspot/Screens/Home.dart';
import 'dart:io';

import 'package:jobspot/model/ingredient.dart';

class addIngr extends StatefulWidget {
  final String foodname;
  final String description;
  final String instruction;
  final File selectedImage;

  const addIngr(
      {Key? key,
      required this.foodname,
      required this.description,
      required this.instruction,
      required this.selectedImage})
      : super(key: key);

  @override
  State<addIngr> createState() => _addIngrState();
}

class _addIngrState extends State<addIngr> {
  late Future<List<Ingredient>> ingredientFuture;
  List<String> selectedList = [];
  bool success = false;

  @override
  void initState() {
    super.initState();
    ingredientFuture = getIngredient();
  }

  Future<List<Ingredient>> getIngredient() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/flutter_login/ingredient.php'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('โหลดรายการวัตถุดิบไม่สำเร็จ');
    }
  }

  Future addFood() async {
    var uri = Uri.parse("http://10.0.2.2/flutter_login/addfood.php");
    var request = http.MultipartRequest('POST', uri);

    var pic =
        await http.MultipartFile.fromPath("image", widget.selectedImage!.path);
    request.files.add(pic);

    request.fields['food_name'] = widget.foodname;
    request.fields['food_desc'] = widget.description;
    request.fields['food_inst'] = widget.instruction;
    request.fields['selectedIngredients'] = selectedList.join(',');

    var response = await request.send();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );

    debugPrint(widget.foodname);
    debugPrint(widget.description);
    debugPrint(widget.instruction);
    debugPrint(selectedList.join(','));

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();

      print('Server Response: $responseBody');
    } else {
      String responseBody = await response.stream.bytesToString();
      print('Server Response: $responseBody');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 162, 53),
          title: Text(
            'Add Ingredients',
            style: GoogleFonts.anuphan(
                textStyle:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          actions: [
            IconButton(
              onPressed: addFood,
              icon: const Icon(Icons.check),
            ),
          ],
          centerTitle: true,
        ),
        body: FutureBuilder<List<Ingredient>>(
          future: ingredientFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else if (snapshot.hasData) {
              final ingredients = snapshot.data!;
              return buildIngredients(ingredients);
            } else {
              return const Text('No user data');
            }
          },
        ),
      );

  Widget buildIngredients(List<Ingredient> ingredients) {
    return Column(children: [
      SizedBox(
        height: 30,
      ),
      Text(
        "กรุณาเลือกวัตถุดิบ",
        style: GoogleFonts.anuphan(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 3, 4, 90)),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: ingredients.map((ingredient) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: FilterChip(
                label: Text(ingredient.ingredient_name),
                selected: selectedList.contains(ingredient.ingredient_id),
                onSelected: (bool value) {
                  setState(() {
                    if (selectedList.contains(ingredient.ingredient_id)) {
                      selectedList.remove(ingredient.ingredient_id);
                    } else {
                      if (selectedList.length < 15) {
                        selectedList.add(ingredient.ingredient_id);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('เลือกวัคถุดิบสูงสุดได้ 15 อย่าง'),
                          ),
                        );
                      }
                    }
                  });
                },
              ),
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
