import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/camera.dart';
/* file: main.dart */

List<Camera> cameras = [];

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

  @override
  void initState() {
    super.initState();
    cameras.add(Camera("Камера на Измайловской"));
    cameras.add(Camera("Камера в Дубне"));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cameras")
      ),
      body: ListView.builder(
        itemCount: cameras.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                  cameras[index].name
              ),
              onTap: () { // NEW from here .// ..
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondPage(index: 1);
                }));
              });
        },
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.index}) : super(key: key);
  final int index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some camera'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/sample1.jpg',
                height: 400,
                width: 400,
            ),
            Text(
                cameras[index].name
            ),
            ListTile(
              //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
              title: Row(
                children: <Widget>[
                  Expanded(child: TextButton(onPressed: () {},child: Text("Вызвать полицию"))),
                  Expanded(child: TextButton(onPressed: () {},child: Text("Открыть дверь"))),
                ],
              ),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }
}