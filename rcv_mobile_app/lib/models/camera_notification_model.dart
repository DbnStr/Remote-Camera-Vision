import 'package:flutter/cupertino.dart';
import 'package:rcv_mobile_app/models/person_model.dart';

class CameraNotification {

  final Image? view;
  final DateTime? viewDateTime;
  final List<Person>? persons;

  CameraNotification({this.view, this.viewDateTime, this.persons});
}