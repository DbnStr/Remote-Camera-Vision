import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rcv_mobile_app/constants.dart';
import 'package:rcv_mobile_app/models/camera_notification_model.dart';
import 'package:rcv_mobile_app/models/coordinates_model.dart';
import 'package:rcv_mobile_app/models/current_camera_model.dart';
import 'package:rcv_mobile_app/models/person_model.dart';

class MQTT {

  final String host;
  final int port;
  final List<String> topics;
  CameraModel? model;

  late MqttServerClient _client;

  MQTT(this.host, this.port, this.topics);

  void initializeMQTTClient() {
    _client = MqttServerClient(host, 'rcv_client')
        ..port = port
        ..logging(on: true)
        ..keepAlivePeriod = 100
        ..onDisconnected = onDisconnected
        ..onConnected = onConnected
        ..onSubscribed = onSubscribed
        ..pongCallback = pong;

    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic('will topic')
        .withWillMessage('Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;
  }

  Future connect() async {
    log('MQTT :: Connecting...');
    try {
      await _client.connect();
    } on NoConnectionException catch (e) {
      log('MQTT :: client exception - $e');
      _client.disconnect();
    } on SocketException catch (e) {
      log('MQTT :: socket exception - $e');
      _client.disconnect();
    }
  }

  void onConnected() {
    log('Client connection was successful');
    try {
      for (String topic in topics) {
        _client.subscribe(topic, MqttQos.atMostOnce);
      }
      _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        log("MQTT :: new message");
        for (MqttReceivedMessage mes in c!) {
          log("MQTT :: receive new message from topic : ${mes.topic}");
          final recMess = mes.payload as MqttPublishMessage;
          final stringMes =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
          Map<String, dynamic> data = jsonDecode(stringMes);

          if (mes.topic == Constants.CURENT_VIEW_TOPIC_NAME) {
            model!.setView(data['image'], DateTime.parse(data['time']));
          }

          if (mes.topic == Constants.RECOGNITION_TOPIC_NAME) {
            final view = data['image'];
            final time = DateTime.parse(data['time']);
            final persons = <Person>[];
            for (Map<String, dynamic> personJson in data['persons']) {
              final coordJson = personJson['coordinates'];
              final coord = Coordinates(
                  coordJson['top'], coordJson['bottom'],
                  coordJson['left'], coordJson['right']);
              persons.add(Person(personJson['id'], personJson['name'], coord));
            }
            model!.addNotification(CameraNotification(
                view: view, viewDateTime: time, persons: persons));
          }
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void onSubscribed(String topic) {
    log('MQTT :: Subscription confirmed for topic $topic');
  }

  void disconnect() {
    log('MQTT :: Disconnecting...');
    try {
      _client.disconnect();
    } catch (e) {
      log(e.toString());
    }
  }

  void onDisconnected() {
    log('MQTT :: Disconnected');
  }

  // Тест публикации текущего view камеры
  Future<void> publishCurrentView() async {
    final builder = MqttClientPayloadBuilder();

    String dateTime = DateTime.now().toString();
    String path = 'assets/images/sample2.jpg';
    final image = await rootBundle.load(path);
    Uint8List imageBytes = image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes);
    String imageString = base64.encode(imageBytes);

    builder.addString(
        json.encode(
            {
              "image": imageString,
              "time": dateTime,
            }
        )
    );

    _client.publishMessage(
        Constants.CURENT_VIEW_TOPIC_NAME, MqttQos.exactlyOnce, builder.payload!);

    log("MQTT :: publish success");

    builder.clear();
  }

  // Тест публикации уведомления о том, что кто-то пришел
  Future<void> publishNotification() async {
    final builder = MqttClientPayloadBuilder();

    String dateTime = DateTime.now().toString();
    String path = 'assets/images/sample2.jpg';
    final image = await rootBundle.load(path);
    Uint8List imageBytes = image.buffer.asUint8List(image.offsetInBytes, image.lengthInBytes);
    String imageString = base64.encode(imageBytes);

    builder.addString(
        json.encode(
            {
              "image": imageString,
              "persons": [
                {
                  "id": 1,
                  "name": "Alexey",
                  "coordinates": {
                    "top": 1,
                    "right": 2,
                    "bottom": 3,
                    "left": 4
                  }
                }
              ],
              "time": dateTime,
            }
        )
    );

    _client.publishMessage(
        Constants.RECOGNITION_TOPIC_NAME, MqttQos.exactlyOnce, builder.payload!);

    log("MQTT :: publish success");

    builder.clear();
  }

  void pong() {
    log('Ping response client callback invoked');
  }
}