import 'package:flutter/material.dart';

class WeightValue extends StatelessWidget {
  final String text;
  final bool isHigher;

  WeightValue({Key key, @required this.text, this.isHigher: false})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: null,
          backgroundColor: isHigher ? Color(0xffDE9DBA) : Color(0xff80BFFD),
          child: Center(
            child: Transform.rotate(
              angle: isHigher ? -45 : 45,
              child: Icon(
                isHigher ? Icons.trending_up : Icons.trending_down,
                color: Colors.grey[200],
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Text(
          text,
          style: TextStyle(color: Colors.grey[300], fontSize: 35),
        ),
      ],
    );
  }
}
