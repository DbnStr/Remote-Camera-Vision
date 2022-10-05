import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../models/current_camera_model.dart';
import '../../services/MQTT.dart';

class SingleCameraScreenViewModel extends ChangeNotifier {
  late String cameraName;
  late CameraModel model;
  late MQTT mqtt;

  void initialise(context) {
    print("init camera screen state");
    cameraName = "CAMERA";
    final topics = <String>[];
    topics.add(Constants.RECOGNITION_TOPIC_NAME);
    topics.add(Constants.CURENT_VIEW_TOPIC_NAME);

    mqtt = MQTT(Constants.MQTT_HOST_NAME,
        Constants.MQTT_PORT,
        topics);
    mqtt.initializeMQTTClient();
    mqtt.connect();

    model = Provider.of<CameraModel>(context);
    mqtt.model = model;

    notifyListeners();
  }

  @override
  void dispose() {
    print('dispose camera screen state');
    mqtt.disconnect();
    super.dispose();
  }
}
