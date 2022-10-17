import 'current_camera_model.dart';

class User {
  final String id;
  List<String> cameras = [];

  User(this.id);

  User.fromJson(this.id, Map<String, dynamic> json) {
    cameras = (json['cameras'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    return {
      'cameras': cameras
    };
  }

  // TODO: make firebase authentication
  // User.fromFirebase(FirebaseUser fUser) {
  //   this.id = fUser.uid;
  // }

  void addCamera(CameraModel camera) {
    cameras.add(camera.id);
  }
}