import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../models/camera_notification_model.dart';
import '../../services/firebase.dart';
import '../notification_screen/notification_screen_view.dart';

class NotificationsScreenViewModel extends ChangeNotifier {
  final DatabaseService db = DatabaseService();
  final List<CameraNotification> notifications;
  List<ui.Image?> images = [];

  //TODO: change depending on data format
  var bbox = [
    [0, 0],
    [0, 0]
  ];

  NotificationsScreenViewModel(this.notifications);

  Future<ui.Image> getImage(String? path) async {
    String url = await db.getImageLink(path);
    var completer = Completer<ImageInfo>();
    var img = NetworkImage(url);
    img.resolve(const ImageConfiguration()).addListener(ImageStreamListener((info, _) {
      completer.complete(info);
    }));
    ImageInfo imageInfo = await completer.future;
    return imageInfo.image;
  }

  getImageByIndex(index){
    if (images.isEmpty) {
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
