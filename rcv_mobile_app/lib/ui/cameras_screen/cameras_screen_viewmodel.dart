import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rcv_mobile_app/services/firebase.dart';
import 'package:rcv_mobile_app/ui/add_person_screen/add_person_screen_view.dart';

import '../../models/current_camera_model.dart';
import '../../models/user_model.dart';
import '../single_camera_screen/single_camera_screen_view.dart';

class CamerasScreenViewModel extends ChangeNotifier {
  final User user;
  final List<CameraModel> cameras = [];
  final DatabaseService db = DatabaseService();

  CamerasScreenViewModel(this.user);

  Future<void> initialise() async {
    print('cameras');
    for (var id in user.cameras) {
      CameraModel camera = await db.getCameraById(id);
      cameras.add(camera);
      print('id: ${camera.id}');
    }

    notifyListeners();
  }

  void openCamera(context, camera) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      print('open');
      return SingleCameraScreenView(camera);
    }));
  }

  void openPersonAdding(context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider(
          create: (_) => CameraModel('defaultCamera', 'Москва'),
          child: AddPersonScreenView());
    }));
  }
}
