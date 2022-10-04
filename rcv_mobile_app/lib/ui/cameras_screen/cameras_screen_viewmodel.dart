import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../camera.dart';

class CamerasScreenViewModel extends ChangeNotifier {
  final List<Camera> cameras = [];

  void initialise() {
    cameras.add(Camera("Камера на Измайловской"));
    cameras.add(Camera("Камера в Дубне"));

    notifyListeners();
  }
}
