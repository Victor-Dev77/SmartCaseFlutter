import 'package:get/get.dart';

class MQTTController extends GetxController {

  static MQTTController get to => Get.find();

  num _wifiValue = 0;
  num get wifiValue => this._wifiValue;

  
  updateWifiSignal(String payload) {
    _wifiValue = int.parse(payload);
    update();
  }

}