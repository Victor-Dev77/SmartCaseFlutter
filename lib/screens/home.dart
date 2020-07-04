import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/components/card_settings.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smartcaseflutter/mqtt/mqtt_client.dart';
import 'package:wifi/wifi.dart';
import 'package:wifi_connector/wifi_connector.dart';

final ssid = "SmartCase";
final password = "SmartCase";

class Home extends StatelessWidget {
  Future<Null> connection() async {
    var res = await WifiConnector.connectToWifi(
        ssid: "SmartCase", password: "SmartCase");
        print("Connexion wifi: $res");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CardSettings(
                text: 'Se déconnecter',
                action: () {
                  AuthController.to.signOut();
                },
              ),
              SizedBox(height: 30),
              CardSettings(
                text: 'MQTT',
                action: () {
                  mqttMain();
                },
              ),
              SizedBox(height: 30),
              CardSettings(
                text: 'WIFI',
                action: () {
                  connection();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
