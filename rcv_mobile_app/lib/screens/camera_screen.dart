import 'dart:developer';

import 'package:flutter/material.dart';

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

  @override
  void initState() {
    log("init camera screen state");
    cameraName = widget.cameraName;
    super.initState();
    // final state = Provider.of<CameraModel>(context);
    // final mqtt = MQTT(Constants.MQTT_HOST_NAME,
    //     Constants.MQTT_PORT,
    //     Constants.TOPIC_NAME,
    //     state);
    // mqtt.connect();
  }

  @override
  void dispose() {
    log('dispose camera screen state');
    // mqttBrowserManager.disconnect();
    super.dispose();
  }

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