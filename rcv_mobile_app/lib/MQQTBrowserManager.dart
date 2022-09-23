import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MQTTBrowserManager {
  MqttServerClient client =
  // MqttBrowserClient('ws://test.mosquitto.org', '');
  // MqttBrowserClient.withPort('ws://test.mosquitto.org', 'mobile_client', 1883);
  //MqttBrowserClient('ws://127.0.0.1:1883', 'flutter01');
  //MqttServerClient client =
  MqttServerClient.withPort('10.0.2.2', 'mobile_client', 1883);
  Future<int> connect() async {
    client.logging(on: true);
    client.keepAlivePeriod = 60;
    /// Set the correct MQTT protocol for mosquito
    client.setProtocolV311();
    /// The ws port for Mosquitto is 8080, for wss it is 8081
    client.port = 1883;
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    final connMessage =
    MqttConnectMessage().startClean().withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      await client.connect('check');
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
    }

    return 0;
  }

  void disconnect(){
    client.disconnect();
  }

  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onConnected() {
    print('MQTTClient::Connected');
  }

  void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    print('MQTTClient::Ping response received');
  }

  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}