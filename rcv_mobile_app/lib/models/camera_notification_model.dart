import 'package:rcv_mobile_app/models/person_model.dart';

class CameraNotification {

  final String? view;
  final DateTime? viewDateTime;
  final List<Person>? persons;

  CameraNotification({this.view, this.viewDateTime, this.persons});

  CameraNotification.fromJson(Map<String, dynamic> json)
      : this(
      view: json['view'] as String?,
      viewDateTime: json['viewDateTime'] != null ?
          DateTime.parse(json['viewDateTime'].toDate().toString()) : null,
      persons: List.from(json['persons'])
          .map((e) => Person.fromJson(Map<String, dynamic>.from(e)))
          .toList()
  );

  Map<String, dynamic> toJson() {
    return {
      'view': view,
      'viewDateTime': viewDateTime,
      'persons': persons?.map((p) => p.toJson()).toList()
    };
  }
}