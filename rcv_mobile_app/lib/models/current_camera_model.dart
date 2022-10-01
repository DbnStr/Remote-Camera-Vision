import 'package:flutter/cupertino.dart';
import 'package:rcv_mobile_app/models/camera_notification_model.dart';

// Здесь храниться информацию о камере. Она включает:
// 1. Информация о том, что видит камера в настоящий момент (кадр и время)
// 2. Информация о уведомлениях (кто пришел)
class CameraModel with ChangeNotifier {

  Image currentView = Image.asset('assets/images/sample1.jpg',
    height: 400,
    width: 400,
  );
  DateTime? currentViewDateTime;
  List<CameraNotification> notifications = <CameraNotification>[];


  void setView(Image view, DateTime viewDateTime) {
    currentView = view;
    currentViewDateTime = viewDateTime;
    notifyListeners();
  }

  void addNotification(CameraNotification notification) {
    notifications.add(notification);
  }
}