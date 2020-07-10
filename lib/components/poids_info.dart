import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smartcaseflutter/components/weight_value.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';
import 'package:smartcaseflutter/controllers/poids_controller.dart';
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
          GetBuilder<PoidsController>(
            builder: (controller) => RichText(
              text: TextSpan(
                text: "${controller.difference}",
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
            child: GetBuilder<PoidsController>(
              builder: (controller) {
                if(controller.isClicked){
                  return Container(
                      // color: Colors.red,
                      child: Transform.scale(
                    scale: 1.70,
                    child: Lottie.asset(
                      Constant.pathVibration,
                      height: 300,
                    ),
                  ));
                } else {
                  return Container(
                    height: 300,
                  );
                }
              },
            )),
        Positioned(
          top: 50,
          left: 1,
          right: 1,
          child: GestureDetector(
            onTap: () {
              PoidsController.to.getPoidsFromESP();
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
    return GetBuilder<PoidsController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            WeightValue(text: "${controller.listPoids[0]}"),
            WeightValue(text: "${controller.listPoids[1]}", isHigher: true),
          ],
        );
      },
    );
  }
}
