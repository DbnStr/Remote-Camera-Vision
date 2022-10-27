import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../../models/camera_notification_model.dart';
import '../../models/person_model.dart';
import '../notification_screen/notification_screen_view.dart';

class NotificationsScreenViewModel extends ChangeNotifier {
  final List<CameraNotification> notifications;
  List<ui.Image?> images = [];

  //TODO: change depending on data format
  var bbox = [
    [800, 200],
    [370, 203]
  ];

  NotificationsScreenViewModel(this.notifications);

  pathToImage(path) async {
    final ByteData bytes = await rootBundle.load(path!);
    final Uint8List bytes_list = bytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes_list);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Future<ui.Image> getImage(path) async {
    return await pathToImage(path);
  }

  getImageByIndex(index){
    if (images.length == 0) {
      return null;
    }
    return images[index];
  }

  Future<void> initialise() async {
    for (int i = 0; i < notifications.length; i++) {
      images.add(await getImage(notifications[i].view));
    }
    notifyListeners();
  }

  void openNotification(context, data, date, image) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NotificationScreenView(data: data, date: date, image: image),
        ));
  }
}
