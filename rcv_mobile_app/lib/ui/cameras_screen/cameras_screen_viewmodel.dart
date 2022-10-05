import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../camera.dart';
import '../../models/current_camera_model.dart';
import '../../screens/camera_screen.dart';

class CamerasScreenViewModel extends ChangeNotifier {
  final List<Camera> cameras = [];

  void initialise() {
    cameras.add(Camera("Камера на Измайловской"));
    cameras.add(Camera("Камера в Дубне"));

    notifyListeners();
  }

  void openCamera(context, index, name) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
          create: (_) => CameraModel(),
          child: CameraScreen(index: index, cameraName: name));
    }));
  }
}
