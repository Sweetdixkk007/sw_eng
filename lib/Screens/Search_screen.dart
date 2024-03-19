import 'package:flutter/material.dart';
import 'package:jobspot/Screens/Home.dart';

void main() {
  runApp(const SearchScreen());
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

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
  List<Map> categories = [
    {"name": "ไข่", "isChecked": false},
    {"name": "ไก่", "isChecked": false},
    {"name": "หมู", "isChecked": false},
    {"name": "กุ้ง", "isChecked": false},
    {"name": "หมึก", "isChecked": false},
    {"name": "ข้าว", "isChecked": false},
    {"name": "น้ำมัน", "isChecked": false},
    {"name": "ซุปก้อน", "isChecked": false},
    {"name": "ซอส", "isChecked": false},
    {"name": "ผักชี", "isChecked": false},
    {"name": "ซีอิ้วดำ", "isChecked": false},
    {"name": "ซีอิ้วขาว", "isChecked": false},
    {"name": "น้ำปลา", "isChecked": false},
    {"name": "พริก", "isChecked": false},
    {"name": "มะนาว", "isChecked": false},
    {"name": "น่ำตาล", "isChecked": false},
    {"name": "หัวหอม", "isChecked": false},
    {"name": "แครอท", "isChecked": false},
    {"name": "แป้ง", "isChecked": false},
    {"name": "กะหล่ำ", "isChecked": false},
    {"name": "กะเพรา", "isChecked": false},
    {"name": "กระเทียม", "isChecked": false},
    {"name": "เกลือ", "isChecked": false},
    {"name": "น้ำมันหอย", "isChecked": false},
    {"name": "กะทิ", "isChecked": false},
    {"name": "ข้าวโพด", "isChecked": false},
    {"name": "เห็ด", "isChecked": false},
    {"name": "ฟักทอง", "isChecked": false},
    {"name": "ใบโหระพา", "isChecked": false},
    {"name": "มะกรูด", "isChecked": false},
    {"name": "มะขาม", "isChecked": false},
    {"name": "ชะอม", "isChecked": false},
    {"name": "ข่า", "isChecked": false},
    {"name": "ตะไคร้", "isChecked": false},
    {"name": "มะเขือ", "isChecked": false},
    {"name": "มะเขือเทศ", "isChecked": false},
    {"name": "ซอสหอยนางรม", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 250, 162, 53),
        title: const Column(
          // ignore: sort_child_properties_last
          children: [
            Text('Home'),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "เลือกวัตุดิบที่คุณมี:",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Column(
                children: categories.map((favorite) {
                  return CheckboxListTile(
                    activeColor: const Color.fromARGB(255, 3, 4, 90),
                    checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    value: favorite["isChecked"],
                    title: Text(favorite["name"]),
                    onChanged: (val) {
                      setState(() {
                        favorite["isChecked"] = val;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Wrap(
                children: categories.map((favorite) {
                  if (favorite["isChecked"] == true) {
                    return Card(
                      elevation: 3,
                      color: const Color.fromARGB(255, 3, 4, 90),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              favorite["name"],
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  favorite["isChecked"] =
                                      !favorite["isChecked"];
                                });
                              },
                              child: const Icon(
                                Icons.delete_forever_rounded,
                                color: Color.fromARGB(255, 3, 4, 90),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return Container();
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
