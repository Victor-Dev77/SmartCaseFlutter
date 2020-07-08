import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcaseflutter/controllers/mqtt_conttroller.dart';

AnimationController scannerAnimationController;

class ScannerLocalisation extends StatefulWidget {
  @override
  _ScannerLocalisationState createState() => _ScannerLocalisationState();
}

class _ScannerLocalisationState extends State<ScannerLocalisation>
    with SingleTickerProviderStateMixin {
  bool isScanning = true;

  Animation<double> _scaleAnimation;
  Animation<double> _widthAnimation;
  Animation<double> _opacityAnimation;
  Animation<Color> _colorAnimation;
  Animation<double> _containerAnimation;
  // Timer _timerUpdateSignal;

  @override
  void initState() {
    super.initState();
    scannerAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 3000))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              scannerAnimationController.repeat();
            }
          });
    _scaleAnimation =
        Tween(begin: 100.0, end: 350.0).animate(scannerAnimationController);
    _widthAnimation =
        Tween(begin: 2.5, end: 10.0).animate(scannerAnimationController);
    _opacityAnimation =
        Tween(begin: 1.0, end: 0.1).animate(scannerAnimationController);
    _colorAnimation =
        ColorTween(begin: Colors.white, end: Colors.lightBlue[100]).animate(
            CurvedAnimation(
                parent: scannerAnimationController, curve: Interval(0.0, 0.6)));
    _containerAnimation = Tween(begin: 0.0, end: 100.0).animate(CurvedAnimation(
        parent: scannerAnimationController, curve: Interval(0.6, 1.0)));
    // scannerAnimationController.forward();
    // _timerUpdateSignal = Timer.periodic(
    //     Duration(seconds: 5), (_) => MQTTController.to.updateIntensity());
  }

  @override
  void dispose() {
    scannerAnimationController.dispose();
    scannerAnimationController = null;
    // _timerUpdateSignal.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Container(
              height: _scaleAnimation.value,
              width: _scaleAnimation.value,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: _widthAnimation.value,
                  )),
            ),
          ),
        ),
        Center(
          child: Container(
            height: 100.0,
            width: 100.0,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _colorAnimation.value,
                boxShadow: [
                  BoxShadow(
                      color: Colors.white.withOpacity(0.4),
                      offset: Offset(-6.0, -6.0),
                      blurRadius: 16.0),
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: Offset(6.0, 6.0),
                      blurRadius: 16.0)
                ]),
            child: Stack(
              children: <Widget>[
                Center(
                  child: Container(
                      height: _containerAnimation.value,
                      width: _containerAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      )),
                ),
                Center(
                  child: GetBuilder<MQTTController>(
                    builder: (mqttController) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: CustomPaint(
                            painter: _HeartPainter(
                              intensity: mqttController.intensityLocalisation,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _HeartPainter extends CustomPainter {
  final int intensity; //0-4
  _HeartPainter({@required this.intensity}) : assert(intensity != null);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    Paint paint1 = Paint();
    paint1
      ..color = _colorFromIntensity()
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    double width = size.width;
    double height = size.height;

    Path path = Path();
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.35);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, paint1);
    canvas.drawPath(path, paint);
  }

  Color _colorFromIntensity() {
    if (intensity == 0)
      return Colors.grey[700];
    else if (intensity == 1)
      return Colors.blueGrey;
    else if (intensity == 2)
      return Colors.yellow;
    else if (intensity == 3)
      return Colors.orange;
    else if (intensity == 4 || intensity > 3) return Colors.red;
    return Colors.blueGrey;
  }

  @override
  bool shouldRepaint(_HeartPainter oldDelegate) {
    return true;
  }
}
