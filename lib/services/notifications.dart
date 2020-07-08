import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';


class NotificationService extends GetxController {

  static NotificationService get to => Get.find();
    
  FlutterLocalNotificationsPlugin localNotif = new FlutterLocalNotificationsPlugin();

  bool boolNotif = true;

  initNotif() async {
    var initSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingsIos = new IOSInitializationSettings();
    var initSettings = new InitializationSettings(initSettingsAndroid, initSettingsIos);
    await localNotif.initialize(initSettings, onSelectNotification: onSelectNotification);
  }
    
  @override
  void onInit() {
    super.onInit();
    initNotif();
  }
    
  Future onSelectNotification(String payload) {
    print("Notif clicked : $payload");
  }

  Future showNotif(int value) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        '1', 'wifi', 'wifi strength',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if(value > 50 && boolNotif){
      await localNotif.show(
        0,
        'PRUDENCE',
        'Attention, vous perdez le réseau ou vous vous eloignez de votre valise !',
        platformChannelSpecifics,
      );
      boolNotif = false;
    } else if(value > 75 || value == 0){
      await localNotif.show(
        0,
        'ATTENTION',
        'Votre valise est hors de portée, revenez vite en arrière !',
        platformChannelSpecifics,
      );
    } else if(value <= 35){
      boolNotif = true;
    }
  }
}