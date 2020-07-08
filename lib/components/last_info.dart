import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class LastInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("build");
    return GetBuilder<MQTTController>(
        init: MQTTController(),
        builder: (controller) {
          return _buildWifiInfo(controller);
        },
    );
  }

  Widget _buildWifiInfo(MQTTController controller) {
    print("***** ${controller.wifiValue}");
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: SignalStrengthIndicator.bars(
              minValue: 0,
              value: (90 - controller.wifiValue+10)*0.01,
              maxValue: 1,
              levels: {
                0: Colors.red,
                0.25: Colors.orange,
                0.50: Colors.yellow,
                0.75: Colors.green,
              },
              size: 50,
              barCount: 4,
              spacing: 0.5,
              //activeColor: randomColor(),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "${controller.wifiValue} KG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color(0xffF9FAFB)),
            ),
          ),
        ),
      ],
    );
  }
}
