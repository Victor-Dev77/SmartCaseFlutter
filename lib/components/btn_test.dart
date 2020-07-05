import 'package:flutter/material.dart';
import 'package:smartcaseflutter/services/mqtt_client.dart';
import 'package:wifi_connector/wifi_connector.dart';

import '../controllers/auth_controller.dart';
import 'card_settings.dart';

class BtnTest extends StatelessWidget {

  // Future<Null> connection() async {
  //   var res = await WifiConnector.connectToWifi(
  //       ssid: "SmartCase", password: "SmartCase");
  //       print("Connexion wifi: $res");
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CardSettings(
          text: 'Se déconnecter',
          action: () {
            AuthController.to.signOut();
          },
        ),
        SizedBox(height: 10),
        CardSettings(
          text: 'MQTT',
          action: () {
            MQTTService.connect();
          },
        ),
        SizedBox(height: 10),
        CardSettings(
          text: 'WIFI',
          action: () {
            // connection();
          },
        ),
      ],
    );
  }
}
