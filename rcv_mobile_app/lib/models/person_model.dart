import 'package:rcv_mobile_app/models/coordinates_model.dart';

class Person {
  final String? id;
  final String? name;
  final Coordinates? faceCoordinates;

  Person(this.id, this.name, this.faceCoordinates);

  Person.fromJson(Map<String, dynamic> json)
      : this(
        json['id'] as String?,
        json['name'] as String?,
        json['faceCoordinates'] as Coordinates?
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'faceCoordinates': faceCoordinates?.toJson()
    };
  }
}