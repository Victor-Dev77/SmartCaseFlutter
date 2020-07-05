import 'dart:async';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:get/get.dart';

// TAJ: 5ae8f88e13c14cc1b990bcae08a71bc2
// VICTOR: a041fdaa48d64d6694d93b469490733d

class MqttClientController extends GetxController {

  static MqttClientController get to => Get.find();

  String _wifiValue = "0";
  String get wifiValue => this._wifiValue;
  String topicWifi = 'wifi/test';

  final client = MqttServerClient.withPort('2.tcp.ngrok.io', '5ae8f88e13c14cc1b990bcae08a71bc2', 16566);

  @override
  void onInit() async {
    super.onInit();
    _wifiValue = wifiValue;
    _connect();
    update();
  }

  void _connect() async {

  client.logging(on: true);
  client.keepAlivePeriod = 20;
  client.autoReconnect = true;
  client.onAutoReconnect = onAutoReconnect;
  client.onDisconnected = onDisconnected;
  client.onConnected = onConnected;
  client.onSubscribed = onSubscribed;

  final connMess = MqttConnectMessage()
      .withClientIdentifier('5ae8f88e13c14cc1b990bcae08a71bc2')
      .keepAliveFor(20) // Must agree with the keep alive set above or not set
      .withWillTopic('wifi/death') // If you set this you must set a will message
      .withWillMessage('Je suis mort FLUTTER')
      .startClean() // Non persistent session for testing
      .withWillQos(MqttQos.atMostOnce);
  print('EXAMPLE::Mosquitto client connecting....');
  client.connectionMessage = connMess;

  try {
    await client.connect("bluecase", "bluecase");
  } on Exception catch (e) {
    print('EXAMPLE::client exception - $e');
    client.disconnect();
  }

  if (client.connectionStatus.state == MqttConnectionState.connected) {
    print('EXAMPLE::Mosquitto client connected');
  } else {
    print(
        'EXAMPLE::ERROR Mosquitto client connection failed - disconnecting, status is ${client.connectionStatus}');
    client.disconnect();
    print("DECONNECTE STATUS");
  }

  client.subscribe(topicWifi, MqttQos.atMostOnce);

  client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
    final MqttPublishMessage recMess = c[0].payload;
    _wifiValue =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);

    /// The above may seem a little convoluted for users only interested in the
    /// payload, some users however may be interested in the received publish message,
    /// lets not constrain ourselves yet until the package has been in the wild
    /// for a while.
    /// The payload is a byte buffer, this will be specific to the topic
    print(
        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $_wifiValue -->');
    print('');
  });
}

void onSubscribed(String topic) {
  print('EXAMPLE::Subscription confirmed for topic $topic');
}

void onAutoReconnect() {
  print(
      'EXAMPLE::onAutoReconnect client callback - Client auto reconnection sequence will start');
}

void onConnected() {
  print(
      'EXAMPLE::OnConnected client callback - Client connection was sucessful');
}

void onDisconnected() {
  print('EXAMPLE::OnDisconnected client callback - Client disconnection - ${client.connectionStatus}');
  if (client.connectionStatus.disconnectionOrigin ==
      MqttDisconnectionOrigin.solicited) {
    print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
  }
  print("DECONNECTER");
}
}