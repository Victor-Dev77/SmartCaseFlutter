import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/components/poids_info.dart';
import 'package:smartcaseflutter/utils/constant_color.dart';

class Poids extends StatelessWidget {
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
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: PoidsInfo(),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
  }
}