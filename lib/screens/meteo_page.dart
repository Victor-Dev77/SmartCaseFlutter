import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/controllers/meteo_controller.dart';

class MeteoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: GetBuilder<MeteoController>(
            init: MeteoController(),
            builder: (controller) {
              if (controller.weather == null)
                return CircularProgressIndicator();
              return Text(controller.weather.name);
            },
          )
        ),
      ),
    );
  }
}