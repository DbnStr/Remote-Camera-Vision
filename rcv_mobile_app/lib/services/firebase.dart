import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/current_camera_model.dart';
import '../models/user_model.dart';

class DatabaseService {
  final userRef = FirebaseFirestore.instance.collection('users').withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.reference.id, snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
  final cameraRef = FirebaseFirestore.instance.collection('cameras').withConverter<CameraModel>(
    fromFirestore: (snapshot, _) => CameraModel.fromJson(snapshot.reference.id, snapshot.data()!),
    toFirestore: (camera, _) => camera.toJson(),
  );

  Future<void> addUser(User user) async {
    return userRef
        .add(user)
        .then((_) => log('firebase :: user added'))
        .catchError((error) => log('firebase :: failed to add user: $error'));
  }

  Future<void> updateUser(User user) async {
    return userRef
        .doc(user.id)
        .update(user.toJson())
        .then((_) => log('firebase :: user updated'))
        .catchError((error) => log('firebase :: failed to update user: $error'));
  }

  Future<void> addCamera(CameraModel camera) async {
    return cameraRef
        .add(camera)
        .then((_) => log('firebase :: camera added'))
        .catchError((error) => log('firebase :: failed to add camera: $error'));
  }

  Future<void> updateCamera(CameraModel camera) async {
    return cameraRef
        .doc(camera.id)
        .update(camera.toJson())
        .then((_) => log('firebase :: camera updated'))
        .catchError((error) => log('firebase :: failed to update camera: $error'));
  }
}