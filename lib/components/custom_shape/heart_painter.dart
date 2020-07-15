import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  final int intensity; //0-4
  HeartPainter({@required this.intensity}) : assert(intensity != null);

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
      return Colors.orange;
    else if (intensity == 3) return Colors.red;
    return Colors.blueGrey;
  }

  @override
  bool shouldRepaint(HeartPainter oldDelegate) {
    return true;
  }
}
