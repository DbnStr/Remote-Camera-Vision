import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

import '../../models/person_model.dart';


class NotificationScreenViewModel extends ChangeNotifier {
  final List<Person> data;
  final DateTime date;

  List<String> persons = ['Человек', 'Не человек'];
  ui.Image? image;
  var bbox = [
    [800, 200],
    [370, 203]
  ];

  NotificationScreenViewModel(this.data, this.date);

  Future<void> initialise(context) async {
    //TODO: delete or change after getting image from MQTT. Convert Image to ui.Image for Canvas widget to work
    final ByteData bytes = await rootBundle.load('assets/images/sample2.jpg');
    final Uint8List bytes_list = bytes.buffer.asUint8List();
    ui.Codec codec = await ui.instantiateImageCodec(bytes_list);
    ui.FrameInfo frame = await codec.getNextFrame();
    image = frame.image;

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
