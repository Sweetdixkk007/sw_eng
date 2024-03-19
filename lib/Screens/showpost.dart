import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class instructionScreen extends StatefulWidget {
    final String userId;
    final String postId;
    final String image;
    final String topic;
    final String descrip;
    final VoidCallback onBackNavigate;

  const instructionScreen({
    Key? key,
        required this.userId,
        required this.postId,
        required this.image,
        required this.topic,
        required this.descrip,
        required this.onBackNavigate,
  }) : super(key: key);

  @override
  State<instructionScreen> createState() => _instructionScreenState();
}

class _instructionScreenState extends State<instructionScreen> {
 TextEditingController comment = TextEditingController();
  Future add_comment() async {
     var id = widget.userId;
     var postid = widget.postId;
  

  var uri = Uri.parse("http://10.0.2.2/flutter_login/comment.php");
  var request = http.MultipartRequest('POST', uri);
  
  request.fields['user_id'] = id;
  request.fields['post_id'] = postid;
  request.fields['comment'] = comment.text;

  print(id);
  print(postid);
  print(comment.text);

  var response = await request.send();

  if (response.statusCode == 200) {
    print('comment Uploaded');
    String responseBody = await response.stream.bytesToString();
    print(responseBody);
  } else {
    print('comment Not Uploaded');
  }
}
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 162, 53),
        title: Text('ข้อมูลอาหาร'),
        leading: IconButton(
          onPressed: () {
            widget.onBackNavigate();
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
                  'http://10.0.2.2/flutter_login/upload/${widget.image}',
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      widget.topic,
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
                    Text(widget.descrip,
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
                          widget.userId,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'comment'
                   ),controller: comment,
                ),
                Container(
                child: TextButton(
                  onPressed: () {
                    add_comment();
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.photo),
                      SizedBox(width: 5.0),
                      Text('add photo'),
                    ],
                  ),
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