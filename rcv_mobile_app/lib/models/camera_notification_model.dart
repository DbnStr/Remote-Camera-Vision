import 'package:rcv_mobile_app/models/person_model.dart';

class CameraNotification {

  final String? view;
  final DateTime? viewDateTime;
  final List<Person>? persons;

  CameraNotification({this.view, this.viewDateTime, this.persons});

  CameraNotification.fromJson(Map<String, dynamic> json)
      : this(
      view: json['view'] as String?,
      viewDateTime: json['viewDateTime'] as DateTime?,
      persons: (json['persons'] as List?)?.cast<Person>()
  );

  Map<String, dynamic> toJson() {
    return {
      'view': view,
      'viewDateTime': viewDateTime,
      'persons': persons?.map((p) => p.toJson()).toList()
    };
  }
}