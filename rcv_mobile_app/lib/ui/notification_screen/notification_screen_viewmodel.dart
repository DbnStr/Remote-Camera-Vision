import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../../models/person_model.dart';


class NotificationScreenViewModel extends ChangeNotifier {
  final List<Person> data;
  final DateTime date;
  final ui.Image image;

  List<String> persons = ['Человек', 'Не человек'];
  var bbox = [
    [800, 200],
    [370, 203]
  ];

  NotificationScreenViewModel(this.data, this.date, this.image);

  Future<void> initialise(context) async {
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
