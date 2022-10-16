import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rcv_mobile_app/services/firebase.dart';
import 'package:rcv_mobile_app/ui/cameras_screen/cameras_screen_view.dart';
import 'package:rcv_mobile_app/models/user_model.dart';

User? defaultUser;

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

  // TODO: delete when connecting firebase authentication
  DatabaseService db = DatabaseService();
  defaultUser = await db.getUserById('defaultUser');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: CamerasScreenView(user: defaultUser!));
  }
}