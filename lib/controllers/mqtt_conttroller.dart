import 'dart:math';

import 'package:get/get.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';

class MQTTController extends GetxController {

  static MQTTController get to => Get.find();

  num _wifiValue = 0;
  num get wifiValue => this._wifiValue;

  int _intensityLocalisation = 1;
  int get intensityLocalisation => this._intensityLocalisation;
  
  updateWifiSignal(String payload) {
    _wifiValue = int.parse(payload).abs();
    update();
  }

  updateIntensity() {
    int value = 10 + Random().nextInt(91); // 10 a 90
    print(value);
    if (value < 25)
      _intensityLocalisation = 4;
    else if (value >= 25 && value < 50)
      _intensityLocalisation = 3;
    else if (value >= 50 && value < 75)
      _intensityLocalisation = 2;
    else if (value >= 75 && value < 90)
      _intensityLocalisation = 1;
    else if (value > 90)
      _intensityLocalisation = 0;
    update();
    if (!scannerAnimationController.isAnimating)
      scannerAnimationController.forward();
  }

}