import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobspot/Screens/Ecom.dart';
import 'package:jobspot/Screens/Instruction.dart';
import 'package:jobspot/Screens/Search_screen.dart';
import 'package:jobspot/Widgets/navbar.dart';
import 'package:http/http.dart' as http;
import 'package:jobspot/Screens/addFood.dart';
import 'package:jobspot/model/food.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var currentButtonState = 0;
  Future<List<Food>> usersFuture = getFoods();
  static Future<List<Food>> getFoods() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2/flutter_login/view_product.php'));

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map<Food>((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load food');
    }
  }

  void buttonClicked() {
    setState(() {
      if (currentButtonState == 0) {
        currentButtonState = 1;
      } else if (currentButtonState == 1) {
        currentButtonState = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const NavBar(),
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Text(
              'Menu List',
              style: GoogleFonts.anuphan(
                  textStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => addFood()),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
            centerTitle: true,
          ),

          
          body: Center(
            child: FutureBuilder<List<Food>>(
              future: usersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else if (snapshot.hasData) {
                  if (currentButtonState == 0) {
                    final users = snapshot.data!;
                    return buildFoods(
                        [for (var user in (users..shuffle()).take(1)) user]
                        // users
                        );
                  } else if (currentButtonState == 1) {
                    final users = snapshot.data!;
                    return buildFoods(
                        [for (var user in (users..shuffle()).take(1)) user]
                        // users
                        );
                  } else {
                    return Text('${snapshot.error}');
                  }
                } else {
                  return const Text('no user data');
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              buttonClicked();
            },
            label: Text(
              'Give me something',
              style: GoogleFonts.anuphan(textStyle: TextStyle(fontSize: 15)),
            ),
            icon: const Icon(Icons.shuffle_outlined),
            backgroundColor: Color.fromARGB(
                255, 4, 6, 126), // Set the background color of FAB
            foregroundColor: Colors.white, // Set the text color of FAB
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      );

  Widget buildFoods(List<Food> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "รายการสุ่มอาหาร",
                  style: GoogleFonts.anuphan(
                    textStyle: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => instructionScreen(
                              foodImg: user.food_img,
                              foodName: user.food_name,
                              description: user.description,
                              instructions: user.instructions,
                              onBackNavigate: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'http://10.0.2.2/flutter_login/upload/${user.food_img}',
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                user.food_name,
                                style: GoogleFonts.anuphan(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 4, 6, 126),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(70),
                            child: Icon(Icons.search,
                                size: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Ecom()),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 4, 6, 126),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(70),
                            child: Icon(Icons.store,
                                size: 30, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
}
