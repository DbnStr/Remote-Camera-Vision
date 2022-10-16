import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../../camera.dart';
import '../notification_screen/notification_screen_view.dart';

class NotificationsScreenViewModel extends ChangeNotifier {
  final List<Camera> notifications = [];
  ui.Image? image;

  //TODO: change depending on data format
  var bbox = [
    [800, 200],
    [370, 203]
  ];

  Future<void> initialise() async {
    //TODO: delete or change after getting image from MQTT. Convert Image to ui.Image for Canvas widget to work
    final ByteData bytes = await rootBundle.load('assets/images/sample2.jpg');
    final Uint8List bytes_list = bytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes_list);
    ui.FrameInfo frame = await codec.getNextFrame();
    image = frame.image;

    notifications.add(Camera("Человек"));
    notifications.add(Camera("Не человек"));

    notifyListeners();
  }

  void openNotification(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreenView(),
        ));
  }
}
