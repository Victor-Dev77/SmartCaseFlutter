import 'package:flutter/material.dart';

class WifiPainter extends StatelessWidget {

  final WifiStyle style;

  const WifiPainter({
    Key key,
    this.style,
  }) : super(key: key);

  WifiPainter.bars({
    Key key,
    @required num value,
    double size,
    int barCount = 3,
    num minValue,
    num maxValue,
    Color activeColor,
    Color inactiveColor,
    Map<num, Color> levels,
    Radius radius,
    bool bevelled = false,
    double spacing = 0.2,
    EdgeInsets margin = EdgeInsets.zero,
  }) : this(
          key: key,
          style: BarWifiStyle(
            value: value,
            minValue: minValue,
            maxValue: maxValue,
            barCount: barCount,
            activeColor: activeColor,
            inactiveColor: inactiveColor,
            levels: levels,
            size: size,
            radius: radius,
            bevelled: bevelled,
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


class BarWifiStyle extends WifiStyle {
  final int barCount;
  final double spacing;
  final Radius radius;
  final Map<num, Color> levels;
  final bool bevelled;

  const BarWifiStyle({
    this.barCount = 3,
    this.spacing,
    this.levels,
    this.bevelled,
    Radius radius,
    num value,
    num minValue,
    num maxValue,
    Color activeColor,
    Color inactiveColor,
    double size,
    EdgeInsets margin,
  })  : radius = radius ?? Radius.zero,
        super(
          value: value,
          minValue: minValue,
          maxValue: maxValue,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          size: size,
          margin: margin,
        );

  @override
  CustomPainter get painter => _BarSignalStrengthIndicatorPainter(this);
}

class _BarSignalStrengthIndicatorPainter extends CustomPainter {
  final BarWifiStyle style;

  const _BarSignalStrengthIndicatorPainter(this.style);

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final barCount = style.barCount;
    final barWidth = w / barCount;
    final spacing = style.spacing * barWidth;
    final barWidthTotal = barWidth - spacing * ((barCount - 1) / barCount);

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
    final Paint activeBarPaint = Paint()..color = thresholds[key];
    final Paint inactiveBarPaint = Paint()..color = style.inactiveColor;

    // draw bars
    for (var i = 1; i <= barCount; i++) {
      final barHeight = h * (i / barCount);
      final left = (i - 1) * (barWidthTotal + spacing);
      final top = h - barHeight;

      final paint = value > keys[i - 1] ? activeBarPaint : inactiveBarPaint;

      Path bar;

      if (style.bevelled) {
        final prevBarHeight = (i == 1) ? 0 : (h * ((i - 1) / barCount));
        bar = Path()
          ..moveTo(left, top + barHeight - prevBarHeight)
          ..lineTo(left + barWidthTotal, top + (spacing * 0.75))
          ..lineTo(left + barWidthTotal, top + barHeight)
          ..lineTo(left, top + barHeight)
          ..close();
      } else {
        final rrect = RRect.fromRectAndRadius(
          Rect.fromLTWH(left, top, barWidthTotal, barHeight),
          style.radius,
        );
        bar = Path()..addRRect(rrect);
      }

      canvas.drawPath(bar, paint);
    }
  }

  double normalizeValue(num value, num min, num max) =>
    (value - min) / (max - min);

  @override
  bool shouldRepaint(_BarSignalStrengthIndicatorPainter oldDelegate) {
    return true;
  }
}