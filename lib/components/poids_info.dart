import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/services/mqtt_client.dart';

class PoidsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return _buildPoidsInfo();
  }
  Widget _buildPoidsInfo() {
    return Container(
      child: Column(
        children: <Widget>[
          Obx(() => 
              Text(
              "${MQTTController.to.poidValue}",
            style: TextStyle(fontSize: 30),
            )
          ),
          RaisedButton(
            onPressed: (){
              MQTTService.publishPoidESP();
            },
          )
        ],
      ),
    );
  }
}

