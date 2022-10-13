import 'package:flutter/cupertino.dart';
import 'package:rcv_mobile_app/models/camera_notification_model.dart';

// Здесь храниться информацию о камере. Она включает:
// 1. Информация о том, что видит камера в настоящий момент (кадр и время)
// 2. Информация о уведомлениях (кто пришел)
class CameraModel with ChangeNotifier {

  final String id;
  late final String? location;
  String? currentView;
  DateTime? currentViewDateTime;
  List<CameraNotification> notifications = [];


  CameraModel(this.id, this.location);

  CameraModel.fromJson(this.id, Map<String, dynamic> json) {
    location = json['location'] as String;
    currentView = json['currentView'] as String;
    currentViewDateTime = json['currentViewDateTime'] as DateTime;
    notifications = (json['notifications'] as List).cast<CameraNotification>();
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'currentView': currentView,
      'currentViewDateTime': currentViewDateTime,
      'notifications': notifications.map((n) => n.toJson()).toList()
    };
  }

  void setView(String view, DateTime viewDateTime) {
    currentView = view;
    currentViewDateTime = viewDateTime;
    notifyListeners();
  }

  void addNotification(CameraNotification notification) {
    notifications.add(notification);
  }
}