import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:smartcaseflutter/mqtt/mqtt_client.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class LastInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    print("build");
    return GetBuilder<MqttClientController>(
        init: MqttClientController(),
        builder: (controller) {
          return _buildWifiInfo(controller);
        },
    );
  }

  Widget _buildWifiInfo(MqttClientController controller) {
    print("***** $controller.wifiValue");
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: SignalStrengthIndicator.sector(
              minValue: 0,
              value: int.parse(controller.wifiValue) != null ? int.parse(controller.wifiValue) : 0,
              maxValue: 1,
              size: 50,
              barCount: 4,
              spacing: 0.5,
              activeColor: randomColor(),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "$controller.wifiValue KG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xffF9FAFB)),
            ),
          ),
        ),
      ],
    );
  }
}
