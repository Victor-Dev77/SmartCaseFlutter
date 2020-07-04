import 'package:get/get.dart';
import 'package:smartcaseflutter/components/btn_test.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/components/features.dart';
import 'package:smartcaseflutter/components/last_info.dart';

final ssid = "SmartCase";
final password = "SmartCase";

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height * 1.35,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: LastInfo(),
                  ),
                  Divider(color: Colors.black, height: 3),
                  Expanded(
                    flex: 2,
                    child: Features(),
                  ),
                  Expanded(
                    child: BtnTest(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
