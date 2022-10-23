import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../services/MQTT.dart';

class AddPersonScreenViewModel extends ChangeNotifier {
  var imagePicker;
  List<XFile>? imageFileList;
  late MQTT mqtt;
  final nameController = TextEditingController();

  void initialise(context) {
    log("AddPersonScreenViewModel :: init add person screen state");
    imagePicker = ImagePicker();
    imageFileList = [];
    mqtt = MQTT(Constants.MQTT_HOST_NAME,
        Constants.MQTT_PORT,
        <String>[]);
    mqtt.initializeMQTTClient();
    mqtt.connect();

    notifyListeners();
  }

  void selectImages() async {
    final List<XFile>? selectedImages = await
    imagePicker.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      imageFileList!.clear();
      imageFileList!.addAll(selectedImages);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    mqtt.disconnect();
    super.dispose();
  }

  void publishNotificationPerson() {
    log(nameController.text);
    mqtt.publishNewRecognizablePerson(nameController.text, imageFileList);
  }
}
