import 'package:smartcaseflutter/controllers/start_app_controller.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/routes.dart';
import 'package:smartcaseflutter/screens/home.dart';
import 'package:smartcaseflutter/screens/login.dart';
import 'package:smartcaseflutter/screens/splashscreen.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/utils/date_handle.dart';

void main() async {
  //Assure que le moteur graphique Flutter est init
  WidgetsFlutterBinding.ensureInitialized();
  // Fixe app mode portrait
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WeMoov',
      theme: ThemeData(
        primaryColor: ConstantColor.primaryColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: ConstantColor.white,
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: InitialBinding(),
      getPages: Router.routes,
      home: GetBuilder<StartAppController>(
        init: StartAppController(),
        builder: (controller) {
          switch (controller.authStatus) {
            case AuthStatus.loading:
              return SplashScreen();
            case AuthStatus.connected:
              return Home();
            case AuthStatus.disconnected:
              return Login();
          }
        },
      ),
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      locale: Locale("fr", "FR"),
    );
  }
}

// Remove Scroll Overlay / Glow in List / Grid
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
    Get.put(DateHandle());
  }

}