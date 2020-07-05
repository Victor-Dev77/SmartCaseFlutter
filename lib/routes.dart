import 'package:smartcaseflutter/screens/destination.dart';
import 'package:smartcaseflutter/screens/home.dart';
import 'package:smartcaseflutter/screens/login.dart';
import 'package:smartcaseflutter/screens/meteo.dart';
import 'package:smartcaseflutter/screens/sign_up.dart';
import 'package:smartcaseflutter/screens/splashscreen.dart';
import 'package:get/get.dart';

class Router {

  static const String splashRoute = "/";
  static const String homeRoute = "/home";
  static const String loginRoute = "/login";
  static const String signUpRoute = "/signup";
  static const String destinationRoute = "/home/destination";
  static const String meteoRoute = "/home/meteo";

  static final routes = {
    splashRoute : GetRoute(page: SplashScreen()),
    homeRoute : GetRoute(page: Home()),
    loginRoute : GetRoute(page: Login()),
    signUpRoute : GetRoute(page: SignUp()),
    destinationRoute: GetRoute(page: Destination()),
    meteoRoute: GetRoute(page: Meteo()),
  };

}
