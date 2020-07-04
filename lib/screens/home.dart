import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/components/card_settings.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:smartcaseflutter/mqtt/mqtt_client.dart';
import 'package:wifi/wifi.dart';
import 'package:wifi_connector/wifi_connector.dart';


final server = "0.tcp.ngrok.io";
final clientId = "fbc0dccd3aaa47a0b775dbff28ff3638";
final port = 13719;
final client = MqttServerClient.withPort(server, clientId, port);

final ssid = "SmartCase";
final password = "SmartCase";

class Home extends StatelessWidget {

 Future<Null> connection() async {
    await WifiConnector.connectToWifi(ssid: "SmartCase", password: "SmartCase");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(children: <Widget>[
        CardSettings(
          text: 'Se déconnecter',
          action: () {
            AuthController.to.signOut(); //logOut();
            // Navigator.pushNamedAndRemoveUntil(context, Router.loginRoute,
            //    ModalRoute.withName(Router.homeRoute));
          },
        ),
        CardSettings(
          text: 'MQTT',
          action: () {
            mqttMain();
            // Navigator.pushNamedAndRemoveUntil(context, Router.loginRoute,
            //    ModalRoute.withName(Router.homeRoute));
          },
        ),
         CardSettings(
          text: 'WIFI',
          action: () {
            connection();
            // Navigator.pushNamedAndRemoveUntil(context, Router.loginRoute,
            //    ModalRoute.withName(Router.homeRoute));
          },
        ),
      ])),
    );
  }
}
