import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcv_mobile_app/models/current_camera_model.dart';
import 'package:rcv_mobile_app/screens/add_person_screen.dart';

import '../constants.dart';
import '../services/MQTT.dart';

class CameraScreen extends StatefulWidget {

  final int index;
  final String cameraName;

  const CameraScreen({Key? key, required this.index, required this.cameraName}) :
        super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  late String cameraName;
  late CameraModel model;
  late MQTT mqtt;

  @override
  void initState() {
    super.initState();
    log("init camera screen state");
    cameraName = widget.cameraName;
    final topics = <String>[];
    topics.add(Constants.RECOGNITION_TOPIC_NAME);
    topics.add(Constants.CURENT_VIEW_TOPIC_NAME);

    mqtt = MQTT(Constants.MQTT_HOST_NAME,
        Constants.MQTT_PORT,
        topics);
    mqtt.initializeMQTTClient();
    mqtt.connect();
  }

  @override
  void dispose() {
    log('dispose camera screen state');
    mqtt.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build camera screen widget');
    model = Provider.of<CameraModel>(context);
    mqtt.model = model;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              cameraName,
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
            model.currentView,
            ListTile(
              //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
              title: Row(
                children: <Widget>[
                  Expanded(child: ElevatedButton(
                    child: Text('Вызвать полицию'),
                    onPressed: () {
                      log("CAMERA SCREEN :: PRESSED");
                      mqtt.publishNotification();
                    },
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
                    Expanded(child: ElevatedButton(
                      child: Text('Добавить человека'),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          // mqttBrowserManager.publishMessage(
                          //     pubTopic, "Increment button pushed ${_counter.toString()} times.");
                          return ChangeNotifierProvider(
                              create: (_) => CameraModel(),
                              child: AddPersonScreen());
                        }));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Color(0xFFB9FC9D)),
                          foregroundColor: MaterialStateProperty.all(Color(0xFF67CF3C)),
                          padding: MaterialStateProperty.all(EdgeInsets.all(10)),
                          minimumSize: MaterialStateProperty.all(Size(200, 50)),
                          maximumSize: MaterialStateProperty.all(Size(200, 50)),
                          textStyle: MaterialStateProperty.all(TextStyle(fontSize: 14))),
                    ),
                  ),
                ],
              ),
            ),
          ], //<Widget>[]
        ), //Column
      ), //Center
    );
  }
}