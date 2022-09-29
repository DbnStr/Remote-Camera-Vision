import 'package:flutter/cupertino.dart';
import 'package:rcv_mobile_app/models/camera_notification_model.dart';

class CameraModel {

  Image? currentView;
  DateTime? currentViewDateTime;
  List<CameraNotification> notifications = <CameraNotification>[];

  void setView(Image view, DateTime viewDateTime) {
    currentView = view;
    currentViewDateTime = viewDateTime;
  }

  void addNotification(CameraNotification notification) {
    notifications.add(notification);
  }
}