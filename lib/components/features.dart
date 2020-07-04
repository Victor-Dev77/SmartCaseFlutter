import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartcaseflutter/utils/functions.dart';

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
        return _featureBtn(
            title: dataBtn[index]["title"], icon: dataBtn[index]["icon"]);
      },
    );
  }

  Widget _featureBtn({@required String title, @required IconData icon}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
            color: randomColor(), borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 60,
              ),
              SizedBox(height: 30),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
