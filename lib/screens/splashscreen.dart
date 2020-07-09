import 'package:lottie/lottie.dart';
import 'package:smartcaseflutter/utils/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Lottie.asset(
              Constant.pathLottie,
              width: 170,
              height: 420
            ),
          ],
        )
      ),
    );
  }
}
