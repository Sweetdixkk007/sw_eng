import 'package:flutter/material.dart';

class instructionScreen extends StatelessWidget {
  final String foodImg;
  final String foodName;
  final String description;
  final String instructions;
  final VoidCallback onBackNavigate;

  const instructionScreen({
    Key? key,
    required this.foodImg,
    required this.foodName,
    required this.description,
    required this.instructions,
    required this.onBackNavigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 162, 53),
        title: Text('ข้อมูลอาหาร'),
        leading: IconButton(
          onPressed: () {
            onBackNavigate();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Image.network(
                  'http://10.0.2.2/flutter_login/upload/${foodImg}',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      foodName,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(description,
                    style: TextStyle(fontSize: 16),),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0,horizontal: 0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          instructions,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
