import 'package:get/get.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';
import 'package:smartcaseflutter/services/mqtt_client.dart';
import 'package:smartcaseflutter/services/notifications.dart';

class MQTTController extends GetxController {

  static MQTTController get to => Get.find();

  num _wifiValue = 0;
  num get wifiValue => this._wifiValue;

  RxDouble _poidValue = 0.0.obs;
  double get poidValue => this._poidValue.value;

  int _intensityLocalisation = 1;
  int get intensityLocalisation => this._intensityLocalisation;

  String _textLocalisation = "Aucune connexion...";
  String get textLocalisation => this._textLocalisation;
  
  
  updateWifiSignal(String payload) {
    if(payload == "Je suis mort" || payload == "Je suis mort FLUTTER") {
      _wifiValue = 0;
    } else {
      _wifiValue = int.parse(payload).abs();
    }
    updateIntensity();
    NotificationService.to.showNotif(_wifiValue);
    update();
  }

  updatePoids(String payload) {
    if(payload == "Je suis mort" || payload == "Je suis mort FLUTTER") {
      _poidValue.value = 0.0;
    } else {
      _poidValue.value = double.parse(payload);
    }
    //update(["poids"]);
  }

  @override
  void onInit() {
    super.onInit();
    MQTTService.connect();
    Get.put(NotificationService());
  }

  updateIntensity() {
    //int value = 10 + Random().nextInt(91); // 10 a 90
    //print(value);
    if (_wifiValue == 0 || _wifiValue > 90) {
      _intensityLocalisation = 0;
      _textLocalisation = "Aucune connexion...";
    }
    else if (_wifiValue < 25) {
      _intensityLocalisation = 4;
      _textLocalisation = "Valise très proche";
    }
    else if (_wifiValue >= 25 && _wifiValue < 50) {
      _intensityLocalisation = 3;
      _textLocalisation = "Valise proche";
    }
    else if (_wifiValue >= 50 && _wifiValue < 75) {
      _intensityLocalisation = 2;
      _textLocalisation = "Valise éloignée";
    }
    else if (_wifiValue >= 75 && _wifiValue < 90) {
      _intensityLocalisation = 1;
      _textLocalisation = "Valise hors de portée";
    }
    if (scannerAnimationController !=null && !scannerAnimationController.isAnimating)
      scannerAnimationController.forward();
    if(_wifiValue == 0 && scannerAnimationController !=null){
      scannerAnimationController.reset();
    }
  }

}