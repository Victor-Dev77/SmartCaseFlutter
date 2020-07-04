import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:signal_strength_indicator/signal_strength_indicator.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class LastInfo extends StatefulWidget {
  @override
  _LastInfoState createState() => _LastInfoState();
}

class _LastInfoState extends State<LastInfo> {

  num signal = 0.6;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 2), (_) => generateSignal());
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Row(
      children: <Widget>[
        Expanded(
          child: Center(
            child: SignalStrengthIndicator.sector(
              minValue: 0,
              value: signal,
              maxValue: 1,
              size: 50,
              barCount: 4,
              spacing: 0.5,
              activeColor: randomColor(),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "$signal KG",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
      ],
    );
  }

  generateSignal() {
    setState(() {
      signal = double.parse((Random().nextDouble()).toStringAsFixed(1));
      print(signal);
    });
  }
}

