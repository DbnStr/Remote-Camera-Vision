import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../camera.dart';
import '../../models/current_camera_model.dart';
import '../single_camera_screen/single_camera_screen_view.dart';

class CamerasScreenViewModel extends ChangeNotifier {
  final List<Camera> cameras = [];

  void initialise() {
    cameras.add(Camera("Архангельская область, город Балашиха, пр. Домодедовская, 56"));
    cameras.add(Camera("Томская область, город Егорьевск, спуск Гагарина, 93"));
    cameras.add(Camera("ул. Ломоносова, 01"));

    notifyListeners();
  }

  void openCamera(context, index, name) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
          create: (_) => CameraModel(),
          child: SingleCameraScreenView(index: index, cameraName: name));
    }));
  }
}
