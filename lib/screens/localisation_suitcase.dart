import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';

class LocalisationPage extends StatefulWidget {
  @override
  _LocalisationPageState createState() => _LocalisationPageState();
}

class _LocalisationPageState extends State<LocalisationPage> {
  int intensity = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScannerLocalisation();
    /*return Scaffold(
      backgroundColor: Color(0xff26282e),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GetBuilder<MQTTController>(
                builder: (controller) {
                  return SizedBox(
                    width: 100,
                    height: 100,
                    child: CustomPaint(
                      painter: _HeartPainter(
                        intensity: controller.intensityLocalisation,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}

