import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobspot/Screens/Ecom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  late SharedPreferences pref;
  late String username = "";
  String id ="";
  String pic = "";
  TextEditingController topic = TextEditingController();
  TextEditingController descrip = TextEditingController();
  final picker = ImagePicker();
  File? _selectedImage;
  // ignore: non_constant_identifier_names
  Future add_post() async {
  var uri = Uri.parse("http://192.168.1.50/flutter_login/post.php");
  var request = http.MultipartRequest('POST', uri);
  var postimage = await http.MultipartFile.fromPath("image", _selectedImage!.path);

  request.fields['user_id'] = id;
  request.files.add(postimage);
  request.fields['topic'] = topic.text;
  request.fields['descrip'] = descrip.text;

  print(id);
  print(username);
  print(pic);
  var response = await request.send();

  if (response.statusCode == 200) {
    print('Post Uploaded');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Ecom()));
  } else {
    print('Post Not Uploaded');
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

  Future<void> dud() async {
  pref = await SharedPreferences.getInstance();
  if (pref.containsKey('username') && pref.containsKey('id') && pref.containsKey('pic')) {
    setState(() {
      username = pref.getString('username') ?? '';
      id = pref.getString('id') ?? '';
      pic = pref.getString('pic') ?? '';
    });
  }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dud();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
<<<<<<< HEAD
          'สร้างโพส',
=======
          'ฝากร้าน',
>>>>>>> 7c1b0eec36a5b1f0c3ef2f2fedde96286294f070
        ),
        actions: [
          TextButton(
            onPressed: () {
              add_post();
            },
            child: const Text(
<<<<<<< HEAD
              'ยืนยัน',
=======
              'Post',
>>>>>>> 7c1b0eec36a5b1f0c3ef2f2fedde96286294f070
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
  children: [
    Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage('http://192.168.1.50/flutter_login/upload/$pic'),
          radius: 25.0,
        ),
        const SizedBox(width: 20.0),
        Text(
          username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ],
    ),
    Container(
      child: TextFormField(
        decoration: const InputDecoration(
<<<<<<< HEAD
          hintText: 'หัวข้อ',
=======
          hintText: 'TOPIC',
>>>>>>> 7c1b0eec36a5b1f0c3ef2f2fedde96286294f070
          border: InputBorder.none,
        ),
        validator: (val) {
          if (val!.isEmpty) {
            return 'Empty';
          }
          return null;
        },
        controller: topic,
      ),
    ),
    Expanded(
      child: Stack(
        children: [
          TextFormField(
            decoration: const InputDecoration(
<<<<<<< HEAD
              hintText: 'รายละเอียด',
=======
              hintText: 'DESCRIPTION',
>>>>>>> 7c1b0eec36a5b1f0c3ef2f2fedde96286294f070
              border: InputBorder.none,
            ),
            maxLines: null, // กำหนด maxLines เป็น null เพื่อให้สามารถเพิ่มบรรทัดใหม่ได้
            validator: (val) {
              if (val!.isEmpty) {
                return 'Empty';
              }
              return null;
            },
            controller: descrip,
          ),
        ],
      ),
    ),
    if (_selectedImage != null)
  Positioned(
    right: 0,
    bottom: 0,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.file(
        _selectedImage!,
        width: 300,
        height: 300,
        fit: BoxFit.contain,
      ),
    ),
  ),
    Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {
              choiceImage();
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo),
                SizedBox(width: 5.0),
<<<<<<< HEAD
                Text('แทรกรูปภาพ'),
=======
                Text('add photo'),
>>>>>>> 7c1b0eec36a5b1f0c3ef2f2fedde96286294f070
              ],
            ),
          ),
        ),
      ],
    ),
  ],
),

      ),
    );
  }
}
