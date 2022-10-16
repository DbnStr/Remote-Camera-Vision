import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rcv_mobile_app/services/firebase.dart';
import 'package:rcv_mobile_app/ui/cameras_screen/cameras_screen_view.dart';

import 'package:rcv_mobile_app/models/user_model.dart';
import 'package:rcv_mobile_app/models/current_camera_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyDhaa9hqaj0adixXiF_Mq1b_Ixl2AYgdRA',
        appId: '1:612117612757:android:5130cf41a3cc6589dfba5c',
        messagingSenderId: '612117612757',
        projectId: 'remote-camera-vision',
    )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: delete when connecting firebase authentication
    // DatabaseService db = DatabaseService();
    User defaultUser = User('defaultUser');
    List<String> locations = [
      'Архангельская область, город Балашиха, пр. Домодедовская, 56',
      'Томская область, город Егорьевск, спуск Гагарина, 93',
      'Томская область, город Егорьевск, спуск Гагарина, 93, город Егорьевск, спуск Гагарина, 93',
      'ул. Ломоносова, 01'
    ];
    for (int i = 0; i < locations.length; i++) {
      CameraModel camera = CameraModel(i.toString(), locations[i]);
      // db.addCamera(camera);
      defaultUser.addCamera(camera);
    }
    // db.addUser(defaultUser);
    log('Main :: ${defaultUser.cameras}');
    return MaterialApp(home: CamerasScreenView(user: defaultUser));
  }
}