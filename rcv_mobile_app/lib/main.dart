import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/MQQTBrowserManager.dart';
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

  int _counter = 0;
  MQTTBrowserManager mqttBrowserManager = MQTTBrowserManager();
  final String pubTopic = "test/counter";

  @override
  void initState() {
    setupMqttClient();
    // setupUpdatesListener();
    super.initState();
    cameras.add(Camera("Камера на Измайловской"));
    cameras.add(Camera("Камера в Дубне"));
  }

  Future<void> setupMqttClient() async {
    await mqttBrowserManager.connect();
    // mqttBrowserManager.subscribe(pubTopic);
  }

  // void setupUpdatesListener() {
  //   mqttBrowserManager
  //       .getMessagesStream()!
  //       .listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
  //     final recMess = c![0].payload as MqttPublishMessage;
  //     final pt =
  //     MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
  //     print('MQTTClient::Message received on topic: <${c[0].topic}> is $pt\n');
  //   });

  @override
  void dispose() {
    // mqttBrowserManager.disconnect();
    super.dispose();
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
              leading: Image.asset('assets/images/camera_icon.jpeg'),
              title: Text(
                  cameras[index].name
              ),
              shape: Border(
                bottom: BorderSide(),

              ),
              onTap: () { // NEW from here .// ..
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // mqttBrowserManager.publishMessage(
                  //     pubTopic, "Increment button pushed ${_counter.toString()} times.");
                  return SecondPage(index: index);
                }));
              });
        },
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  SecondPage({Key? key, required this.index}) :
        super(key: key);
        // imagePath = 'assets/images/sample ' + (index + 1).toString() + '.jpg';;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              cameras[index].name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  height: 2),
            ),
            const Divider(
              height: 40,
              thickness: 5,
              endIndent: 0,
              color: Colors.black,
            ),
            Image.asset('assets/images/sample1.jpg',
                height: 400,
                width: 400,
            ),
            ListTile(
              //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
              title: Row(
                children: <Widget>[
                  Expanded(child: ElevatedButton(
                    child: Text('Вызвать полицию'),
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFFC3503)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        minimumSize: MaterialStateProperty.all(Size(200, 50)),
                        maximumSize: MaterialStateProperty.all(Size(200, 50)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14))),
                  )),
                  Expanded(child: ElevatedButton(
                    child: Text('Открыть дверь'),
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color(0xFFB9FC9D)),
                        foregroundColor: MaterialStateProperty.all(Color(0xFF67CF3C)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                        minimumSize: MaterialStateProperty.all(Size(200, 50)),
                        maximumSize: MaterialStateProperty.all(Size(200, 50)),
                        textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14))),
                  )),
                ],
              ),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }
}