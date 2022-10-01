import 'package:rcv_mobile_app/models/coordinates_model.dart';

class Person {

  final int? id;
  final String? name;
  final Coordinates? faceCoordinates;

  Person(this.id, this.name, this.faceCoordinates);
}