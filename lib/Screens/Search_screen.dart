import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:jobspot/Screens/Home.dart';
import 'package:http/http.dart' as http;
import 'package:jobspot/Screens/showRecipe.dart';
import 'package:jobspot/model/ingredient.dart';

void main() {
  runApp(const SearchScreen());
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late Future<List<Ingredient>> ingredientFuture;

  List<String> selectedList = [];

  @override
  void initState() {
    super.initState();
    ingredientFuture = getIngredient();
  }

  Future<List<Ingredient>> getIngredient() async {
    final response = await http
        .get(Uri.parse('http://192.168.1.50/flutter_login/ingredient.php'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map<Ingredient>((json) => Ingredient.fromJson(json)).toList();
    } else {
      throw Exception('โหลดรายการวัตถุดิบไม่สำเร็จ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 162, 53),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('เลือกรายการวัตถุดิบ'),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => showRecipe(selectedList:selectedList)),
              );
              print(selectedList);
            },
            icon: const Icon(Icons.check),
          ),
        ],
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
  }

  Widget buildIngredients(List<Ingredient> ingredients) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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
                    if (selectedList.length < 5) {
                      selectedList.add(ingredient.ingredient_id);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('เลือกวัคถุดิบสูงสุดได้ 5 อย่าง'),
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
    );
  }
}
