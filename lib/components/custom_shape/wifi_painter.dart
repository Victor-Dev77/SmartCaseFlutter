import 'dart:math';

import 'package:flutter/material.dart';

class WifiPainter extends StatelessWidget {

  final WifiStyle style;

  const WifiPainter({
    Key key,
    this.style,
  }) : super(key: key);
  
  WifiPainter.sector({
    Key key,
    @required num value,
    double size,
    int barCount = 3,
    num minValue,
    num maxValue,
    Color activeColor,
    Color inactiveColor,
    Map<num, Color> levels,
    bool rounded = false,
    double spacing = 0.3,
    EdgeInsets margin = EdgeInsets.zero,
  }) : this(
          key: key,
          style: SectorSignalStrengthIndicatorStyle(
            value: value,
            minValue: minValue,
            maxValue: maxValue,
            barCount: barCount,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            levels: levels,
            size: size,
            rounded: rounded,
            spacing: spacing,
            margin: margin,
          ),
        );

   @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double _size = style.size ?? iconTheme.size;

    return Container(
      margin: style.margin,
      child: SizedBox(
        width: _size,
        height: _size,
        child: CustomPaint(
          painter: style.painter,
        ),
      ),
    );
  }
}

abstract class WifiStyle {
  final num value;
  final num minValue;
  final num maxValue;
  final Color activeColor;
  final Color inactiveColor;
  final double size;
  final EdgeInsets margin;

  const WifiStyle({
    @required this.value,
    num minValue,
    num maxValue,
    Color activeColor,
    Color inactiveColor,
    this.size,
    this.margin = EdgeInsets.zero,
  })  : minValue = minValue ?? 0.0,
        maxValue = maxValue ?? 1.0,
        activeColor = activeColor ?? const Color(0xFF4CAF50),
        inactiveColor = inactiveColor ?? const Color(0xFFC8E6C9);

  /// Painter is responsible for painting indicator.
  CustomPainter get painter;

  @override
  String toString() => 'WifiStyle('
      '$value, $minValue, $maxValue, $size)';
}

class SectorSignalStrengthIndicatorStyle extends WifiStyle {
  final int barCount;
  final double spacing;
  final bool rounded;
  final Map<num, Color> levels;

  const SectorSignalStrengthIndicatorStyle({
    this.barCount,
    this.spacing,
    this.levels,
    this.rounded,
    num value,
    num minValue,
    num maxValue,
    Color activeColor,
    Color inactiveColor,
    double size,
    EdgeInsets margin,
  }) : super(
          value: value,
          minValue: minValue,
          maxValue: maxValue,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          size: size,
          margin: margin,
        );

  @override
  CustomPainter get painter => _SectorSignalStrengthIndicatorPainter(this);
}

class _SectorSignalStrengthIndicatorPainter extends CustomPainter {
  final SectorSignalStrengthIndicatorStyle style;

  const _SectorSignalStrengthIndicatorPainter(this.style);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final barCount = style.barCount;
    final strokeWidth = h / barCount;
    final spacing = style.spacing * strokeWidth;

    final value = normalizeValue(style.value, style.minValue, style.maxValue);

    final Map<num, Color> thresholds = style.levels ?? {};
    // remove thresholds where value is out of range
    thresholds
        .removeWhere((key, _) => key < style.minValue || key > style.maxValue);

    // when there are no threshold or number of thresholds does not correspond
    // with number of bars, use (create) 'default' thresholds
    if (thresholds.isEmpty || thresholds.keys.length != barCount) {
      thresholds.clear();
      for (var i = 0; i < barCount; i++) {
        thresholds.addAll({i / barCount: style.activeColor});
      }
    }

    final keys = thresholds.keys.toList()..sort();
    final key = keys.lastWhere((t) => t < value, orElse: () => keys.first);

    final Paint activeBarPaint = Paint()
      ..color = thresholds[key]
      ..strokeWidth = strokeWidth - spacing
      ..strokeCap = style.rounded ? StrokeCap.round : StrokeCap.butt
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final Paint inactiveBarPaint = Paint()
      ..color = style.inactiveColor
      ..strokeWidth = strokeWidth - spacing
      ..strokeCap = style.rounded ? StrokeCap.round : StrokeCap.butt
      ..style = PaintingStyle.stroke;

    final Paint activeFirstPaint = Paint()
      ..color = thresholds[key]
      ..strokeWidth = strokeWidth - spacing
      ..style = PaintingStyle.fill;

    final Paint inactiveFirstPaint = Paint()
      ..color = style.inactiveColor
      ..strokeWidth = strokeWidth - spacing
      ..style = PaintingStyle.fill;

    // draw segments
    for (int i = 1; i <= barCount; i++) {
      final offset = (barCount - i) * strokeWidth;
      final radius = w - offset - (strokeWidth / 2);

      final paint = value > keys[i - 1] ? activeBarPaint : inactiveBarPaint;
      final firstPaint =
          value > keys[i - 1] ? activeFirstPaint : inactiveFirstPaint;

      canvas.clipRect(Rect.fromLTWH(0, 0, w, h));

      if (i == 1) {
        // draw first segment
        if (style.rounded) {
          final r = strokeWidth / pi * 1.3;
          canvas.drawCircle(size.bottomLeft(Offset(r, -r)), r, firstPaint);
        } else {
          canvas.drawArc(
            Rect.fromCircle(
              center: size.bottomLeft(Offset.zero),
              radius: strokeWidth - (spacing / 2),
            ),
            -90 * (pi / 180),
            90 * (pi / 180),
            true,
            firstPaint,
          );
        }
      } else {
        // draw other segments
        final offset = style.rounded ? strokeWidth / 2.0 : 0.0;
        canvas.drawArc(
          Rect.fromCircle(
            center: size.bottomLeft(Offset(offset, -offset)),
            radius: radius - offset,
          ),
          -90 * (pi / 180),
          90 * (pi / 180),
          false,
          paint,
        );
      }
    }
  }

  double normalizeValue(num value, num min, num max) =>
    (value - min) / (max - min);

  @override
  bool shouldRepaint(_SectorSignalStrengthIndicatorPainter oldDelegate) {
    return true;
  }
}