import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/camera.dart';
/* file: main.dart */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  List<Camera> cameras = [];

  @override
  void initState() {
    super.initState();
    cameras.add(Camera("Камера на Измайловской"));
    cameras.add(Camera("Камера в Дубне"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cameras")),
      body: ListView.builder(
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(cameras[index].name));
        },
      ),
    );
  }
}
