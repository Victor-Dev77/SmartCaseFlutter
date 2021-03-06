import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/screens/destination_page.dart';
import 'package:smartcaseflutter/screens/home.dart';
import 'package:smartcaseflutter/screens/localisation_suitcase.dart';
import 'package:smartcaseflutter/screens/login.dart';
import 'package:smartcaseflutter/screens/poids.dart';
import 'package:smartcaseflutter/screens/sign_up.dart';
import 'package:smartcaseflutter/screens/splashscreen.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/screens/weather_page.dart';

class Router {

  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String destinationRoute = "/home/destination";
  static const String meteoRoute = "/home/meteo";
  static const String localisationRoute = "/home/localisation";
  static const String poidsRoute = "/home/poids";

  static final routes = [
    GetPage(name: splashRoute, page: () => SplashScreen()),
    GetPage(name: homeRoute, page: () => Home(), binding: _HomeBinding()),
    GetPage(name: loginRoute, page: () => Login()),
    GetPage(name: signUpRoute, page: () => SignUp()),
    GetPage(name: destinationRoute, page: () => DestinationPage()),
    GetPage(name: meteoRoute, page: () => WeatherPage()),
    GetPage(name: localisationRoute, page: () => LocalisationPage()),
    GetPage(name: poidsRoute, page: () => Poids()),
  ];
}

class _HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MQTTController());
  }
}