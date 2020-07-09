import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/components/features.dart';
import 'package:smartcaseflutter/components/last_info.dart';
import 'package:smartcaseflutter/controllers/auth_controller.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff293251),
      body: SafeArea(
        //child: SingleChildScrollView(
          child: Container(
            width: Get.width,
            height: Get.height * 1.35,
           /* decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff34393f), Color(0xff17181C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),*/
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: LastInfo(),
                  ),
                  Expanded(
                    flex: 4,
                    child: Features(),
                  ),
                ],
              ),
            ),
          ),
        //),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff80BFFD),
        onPressed: (){
          AuthController.to.signOut();
        },
        child: Icon(FontAwesomeIcons.signOutAlt),

      ),
    );
  }
}
