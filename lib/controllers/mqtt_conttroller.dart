import 'dart:math';

import 'package:get/get.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';

class MQTTController extends GetxController {

  static MQTTController get to => Get.find();

  num _wifiValue = 0;
  num get wifiValue => this._wifiValue;

  int _intensityLocalisation = 1;
  int get intensityLocalisation => this._intensityLocalisation;

  String _textLocalisation = "Aucune connexion...";
  String get textLocalisation => this._textLocalisation;
  
  updateWifiSignal(String payload) {
    _wifiValue = int.parse(payload).abs();
    update();
  }

  updateIntensity() {
    int value = 10 + Random().nextInt(91); // 10 a 90
    print(value);
    if (value < 25) {
      _intensityLocalisation = 4;
      _textLocalisation = "Valise très proche";
    }
    else if (value >= 25 && value < 50) {
      _intensityLocalisation = 3;
      _textLocalisation = "Valise proche";
    }
    else if (value >= 50 && value < 75) {
      _intensityLocalisation = 2;
      _textLocalisation = "Valise éloignée";
    }
    else if (value >= 75 && value < 90) {
      _intensityLocalisation = 1;
      _textLocalisation = "Valise hors de portée";
    }
    else if (value > 90) {
      _intensityLocalisation = 0;
      _textLocalisation = "Aucune connexion...";
    }
    update();
    if (!scannerAnimationController.isAnimating)
      scannerAnimationController.forward();
  }

}