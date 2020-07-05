import 'package:flutter/material.dart';

class FeatureBtn extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  FeatureBtn(
      {Key key,
      @required this.title,
      @required this.icon,
      @required this.onTap})
      : assert(title != null),
        assert(icon != null),
        assert(onTap != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              // color: randomColor(),
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  /*  Color(0xff654C91),
              Color(0xff181A6E),*/
                  Color(0xff1D4B69),
                  Color(0xff10254c),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 5,
                )
              ]),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 60,
                  color: Color(0xffF9FAFB),
                ),
                SizedBox(height: 30),
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xffF9FAFB)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
