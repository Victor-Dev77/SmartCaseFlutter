import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:smartcaseflutter/components/custom_shape/wifi_painter.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcaseflutter/controllers/poids_controller.dart';
import 'package:smartcaseflutter/utils/constant.dart';

class LastInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return _buildWifiInfo();
  }

  Widget _buildWifiInfo() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Obx(() => Center(
                child: MQTTController.to.wifiValue != 0
                    ? WifiPainter.bars(
                        minValue: 0,
                        value: (100 - MQTTController.to.wifiValue) * 0.01,
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
                      )
                    : Lottie.asset(Constant.pathNoWifi,
                        width: 100, height: 250),
              )),
        ),
        Expanded(
          child: Center(child: GetBuilder<PoidsController>(
            builder: (controller) {
              return Text(
                "${controller.difference} KG",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color(0xffF9FAFB)),
              );
            },
          )),
        ),
      ],
    );
  }
}
