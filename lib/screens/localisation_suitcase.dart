import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';

class LocalisationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff384366),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
            child: Stack(
              overflow: Overflow.visible,
          children: <Widget>[
            ScannerLocalisation(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 70),
                  child: GetBuilder<MQTTController>(
                    builder: (controller) {
                      return Text(
                        controller.textLocalisation,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      );
                    },
                  )),
            )
          ],
        )),
      ),
    );
  }
}