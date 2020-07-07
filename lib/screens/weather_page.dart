import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/components/weather_ui.dart';
import 'package:smartcaseflutter/controllers/weather_controller.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff293251),
      body: Container(
        child: Center(
          child: GetBuilder<WeatherController>(
            init: WeatherController(),
            builder: (controller) {
              if (controller.weather == null)
                return CircularProgressIndicator();
              return WeatherUI(controller.weather);
            },
          ),
        ),
      ),
    );
  }
}