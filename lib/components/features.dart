import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/components/feature_btn.dart';
import 'package:smartcaseflutter/utils/functions.dart';

import '../routes.dart';

class Features extends StatelessWidget {
  final List<Map<String, dynamic>> dataBtn = [
    {
      "title": "Localiser",
      "icon": Icons.place,
    },
    {
      "title": "Poids",
      "icon": FontAwesomeIcons.weightHanging,
    },
    {
      "title": "Météo",
      "icon": FontAwesomeIcons.cloudSun,
    },
    {
      "title": "Destination",
      "icon": FontAwesomeIcons.streetView,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: dataBtn.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 0, mainAxisSpacing: 0),
      itemBuilder: (ctx, index) {
        return FeatureBtn(
          title: dataBtn[index]["title"],
          icon: dataBtn[index]["icon"],
          onTap: () {
            if (index == 2)
              Get.toNamed(Router.meteoRoute);
            else if (index == 3)
              Get.toNamed(Router.destinationRoute);
            else 
              print("$index click");
          },
        );
      },
    );
  }
}
