import 'package:flutter/material.dart';
import 'package:rcv_mobile_app/ui/cameras_screen/cameras_screen_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: CamerasScreenView());
  }
}

