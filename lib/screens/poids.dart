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
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => print("refresh"),
              icon: Icon(
                Icons.refresh,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PoidsInfo(),
      ),
    );
  }
}
