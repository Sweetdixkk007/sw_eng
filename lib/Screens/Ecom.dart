import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jobspot/Screens/AddPost.dart';
import 'package:jobspot/Screens/showpost.dart';
import 'package:jobspot/Widgets/poest.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;


class Ecom extends StatefulWidget {
  const Ecom({super.key});

  @override
  State<Ecom> createState() => _EcomState();
}

class _EcomState extends State<Ecom> {
  Future<List<postModel>> postFuture = getPost();
  static Future<List<postModel>> getPost() async {
    final response = await http.get(Uri.parse('http://192.168.1.50/flutter_login/viewpost.php'));


    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));
      return body.map<postModel>((json) => postModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load post');
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget buildPost(List<postModel> post) => ListView.builder(
        itemCount: post.length,
        itemBuilder: (context, index) {
          final user = post[index];
          return InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => instructionScreen(
          userId: user.userId,
          postId: user.postId,
          image: user.image,
          userimage: user.image,
          topic: user.topic,
          descrip: user.descrip,
          onBackNavigate: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  },
  child: Card(
    child: ListTile(
      title: Text(user.topic),
      subtitle: Text(user.descrip),
    ),
  ),
);
        }
      );
    return Scaffold(
      appBar: AppBar(
        title: const Text(

          'โพสทั้งหมด',

        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft, child: const AddPost()));
            },
            child: const Text(

              'เพิ่มโพส',

              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
          const SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: Center(child: FutureBuilder<List<postModel>>(future: postFuture, builder: (context, snapshot){if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                final recipe = snapshot.data!;
                return buildPost(recipe);
              } else {
                return const Text('no Post data');
              }}),),
    );
   

  }
}
