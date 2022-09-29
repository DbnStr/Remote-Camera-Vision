import 'dart:developer';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:rcv_mobile_app/models/current_camera_model.dart';

class MQTT {

  final String host;
  final int port;
  final String topic;
  final CameraModel model;

  late MqttServerClient _client;

  MQTT(this.host, this.port, this.topic, this.model);

  void initializeMQTTClient() {
    _client = MqttServerClient(host, 'rcv_client')
        ..port = port
        ..logging(on: true)
        ..keepAlivePeriod = 20
        ..onDisconnected = onDisconnected
        ..onConnected = onConnected
        ..onSubscribed = onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .withWillTopic(
        'willtopic') // If you set this you must set a will message
        .withWillMessage('My Will message')
        .startClean() // Non persistent session for testing
        .withWillQos(MqttQos.atLeastOnce);
    _client.connectionMessage = connMess;
  }

  Future connect() async {
    log('Connecting....');
    try {
      await _client.connect();
    } on NoConnectionException catch (e) {
      // Raised by the client when connection fails.
      log('EXAMPLE::client exception - $e');
      _client.disconnect();
    } on SocketException catch (e) {
      // Raised by the socket layer
      log('EXAMPLE::socket exception - $e');
      _client.disconnect();
    }
  }

  void onSubscribed(String topic) {
    log('EXAMPLE::Subscription confirmed for topic $topic');
  }

  void onDisconnected() {
    log('Disconnected');
  }

  void onConnected() {
    log('Client connection was successful');
    try {
      _client.subscribe(topic, MqttQos.atMostOnce);
      _client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
        final recMess = c![0].payload as MqttPublishMessage;
        final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        log(
            'EXAMPLE::Change notification:: ---------------> topic is <${c[0]
                .topic}>, payload is <-- $pt -->');
        log('');
      });
    } catch (e) {
      log(e.toString());
    }
  }
}