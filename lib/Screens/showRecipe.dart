import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:jobspot/Screens/Instruction.dart';
import 'package:jobspot/Screens/Search_screen.dart';
import 'dart:convert';
import 'package:jobspot/model/food.dart';

class showRecipe extends StatefulWidget {
  final List<String> selectedList;
  const showRecipe({Key? key, required this.selectedList}) : super(key: key);

  @override
  State<showRecipe> createState() => _showRecipeState();
}

class _showRecipeState extends State<showRecipe> {
  late Future<List<Food>> recipeFuture;
  @override
  void initState() {
    super.initState();
    recipeFuture = fetchRecipes();
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 250, 162, 53),

          title: const Text('อาหารที่พบ'),
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List<Food>>(
            future: recipeFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final recipe = snapshot.data!;
                if (recipe.isEmpty) {
                  return const Text('ไม่พบอาหารตามวัตถุดิบดังกล่าว');
                } else {
                  return buildRecipe(recipe);
                }
              }
              return const Text('Something went wrong');
            },
          ),
        ),
      );

  Future<List<Food>> fetchRecipes() async {
    final url = Uri.parse('http://192.168.1.50/flutter_login/recipe.php');
    final response = await http.post(
      url,
      body: {'selectedIngredients': widget.selectedList.join(',')},
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      final List<Food> recipes =
          body.map((json) => Food.fromJson(json)).toList();
      return recipes;
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Widget buildRecipe(List<Food> recipes) => ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return Card(
            child: Card(
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => instructionScreen(
                        foodImg: recipe.food_img,
                        foodName: recipe.food_name,
                        description: recipe.description,
                        instructions: recipe.instructions,
                        onBackNavigate: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                  print(recipe.food_img);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'http://192.168.1.50/flutter_login/upload/${recipe.food_img}'),
                      ),
                      title: Text(recipe.food_name),
                      subtitle: Text(recipe.description),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
}
