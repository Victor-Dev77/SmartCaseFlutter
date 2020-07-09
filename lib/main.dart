import 'package:smartcaseflutter/controllers/auth_controller.dart';
import 'package:smartcaseflutter/controllers/user_controller.dart';
import 'package:smartcaseflutter/routes.dart';
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
      title: 'BLUESMART',
      theme: ThemeData(
        primaryColor: ConstantColor.primaryBlue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: ConstantColor.primaryBlue,
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      initialBinding: InitialBinding(),
      getPages: Router.routes,
      initialRoute: Router.splashRoute,
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
    Get.put(AuthController());
    Get.put(DateHandle());
  }

}