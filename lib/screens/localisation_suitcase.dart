import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:smartcaseflutter/components/scanner_localisation.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';

class LocalisationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff293251),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff293251),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: ConstantColor.white,
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        height: Get.height + kToolbarHeight,
        width: double.infinity,
        child: Center(
            child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            ScannerLocalisation(),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 30, left: 20),
                  child: GetBuilder<MQTTController>(
                    builder: (controller) {
                      return Text(
                        controller.textLocalisation,
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      );
                    },
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
