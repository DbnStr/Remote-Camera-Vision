import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/MQTT.dart';
import '../constants.dart';
import 'package:provider/provider.dart';
import 'package:rcv_mobile_app/models/current_camera_model.dart';

class AddPersonScreen extends StatefulWidget {

  @override
  AddPersonScreenState createState() => AddPersonScreenState();
}

class AddPersonScreenState extends State<AddPersonScreen> {
  var imagePicker;
  List<XFile>? imageFileList;
  late MQTT mqtt;
  final nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    imagePicker = new ImagePicker();
    imageFileList = [];
    final topics = <String>[];
    topics.add(Constants.NEW_PERSON_TOPIC_NAME);
    mqtt = MQTT(Constants.MQTT_HOST_NAME,
        Constants.MQTT_PORT,
        topics);
    mqtt.initializeMQTTClient();
    mqtt.connect();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    setState((){});
  }

  @override
  void dispose() {
    nameController.dispose();
    mqtt.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Добавить человека")),
      body: Column(
        children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  selectImages();
                },
                child: Text('Выбрать фотографии'),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      itemCount: imageFileList!.length,
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Image.file(File(imageFileList![index].path),
                          fit: BoxFit.cover,);
                      }),
                ),
              ),
            TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Введите имя человека',
              ),
              controller: nameController,
          ),
          ElevatedButton(
            child: Text('Добавить'),
            onPressed: () {
              mqtt.publishNotificationPerson(nameController.text, imageFileList);
            //   Navigator.push(context, MaterialPageRoute(builder: (context) {
            //     // mqttBrowserManager.publishMessage(
            //     //     pubTopic, "Increment button pushed ${_counter.toString()} times.");
            //     return ChangeNotifierProvider(
            //         create: (_) => CameraModel(),
            //         child:  CameraScreen(index: index, cameraName: _cameras[index].name));
            //   }));
            },
          ),
        ],
      ),
    );
  }
}
