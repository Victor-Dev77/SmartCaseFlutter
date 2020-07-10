import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcaseflutter/components/weight_value.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/services/mqtt_client.dart';
import 'package:smartcaseflutter/utils/constant.dart';

class PoidsInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("build");
    return _buildPoidsInfo();
  }

  Widget _buildPoidsInfo() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Obx(
            () => RichText(
              text: TextSpan(
                text: "${MQTTController.to.poidValue}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                    text: " kg",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ),
          ),
          _buildBtnGetPoids(),
          _buildLowerHigher(),
        ],
      ),
    );
  }

  Widget _buildBtnGetPoids() {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Container(
              // color: Colors.red,
              child: Transform.scale(
            scale: 1.70,
            child: Lottie.asset(
              Constant.pathVibration,
              height: 300,
            ),
          )),
        ),
        Positioned(
          top: 50,
          left: 1,
          right: 1,
          child: GestureDetector(
            onTap: () {
              print("ok");
              //MQTTService.publishPoidESP();
            },
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff6EC0FF),
                      Color(0xff364369),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 5,
                    )
                  ]),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Icon(
                    FontAwesomeIcons.weightHanging,
                    size: 80,
                    color: Color(0xffF9FAFB),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildLowerHigher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        WeightValue(text: "47.5"),
        WeightValue(text: "51.3", isHigher: true),
      ],
    );
  }
}
