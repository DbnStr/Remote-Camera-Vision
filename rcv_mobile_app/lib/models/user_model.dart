import 'current_camera_model.dart';

class User {
  final String id;
  List<CameraModel> cameras = [];

  User(this.id);

  User.fromJson(this.id, Map<String, dynamic> json) {
    cameras = (json['cameras'] as List).cast<CameraModel>();
  }

  Map<String, dynamic> toJson() {
    return {
      'cameras': cameras.map((c) => c.id).toList()
    };
  }

  // TODO: make firebase authentication
  // User.fromFirebase(FirebaseUser fUser) {
  //   this.id = fUser.uid;
  // }

  void addCamera(CameraModel camera) {
    cameras.add(camera);
  }
}