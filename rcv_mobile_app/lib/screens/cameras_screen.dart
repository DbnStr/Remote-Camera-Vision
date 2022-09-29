import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/screens/camera_screen.dart';

import '../camera.dart';

class CamerasScreen extends StatefulWidget {
  const CamerasScreen({Key? key}) : super(key: key);

  @override
  State<CamerasScreen> createState() => _CamerasScreenState();
}

class _CamerasScreenState extends State<CamerasScreen> {

  final List<Camera> _cameras = [];

  @override
  void initState() {
    log("Cameras Screen init state");
    _cameras.add(Camera("Камера на Измайловской"));
    _cameras.add(Camera("Камера в Дубне"));

    super.initState();
  }

  @override
  void dispose() {
    log('Cameras screen dispose state');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Cameras")
      ),
      body: ListView.builder(
        itemCount: _cameras.length,
        itemBuilder: (context, index) {
          return ListTile(
              leading: Image.asset('assets/images/camera_icon.jpeg'),
              title: Text(
                  _cameras[index].name
              ),
              shape: Border(
                bottom: BorderSide(),
              ),
              onTap: () { // NEW from here .// ..
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  // mqttBrowserManager.publishMessage(
                  //     pubTopic, "Increment button pushed ${_counter.toString()} times.");
                  return CameraScreen(index: index, cameraName: _cameras[index].name);
                }));
              });
        },
      ),
    );
  }
}