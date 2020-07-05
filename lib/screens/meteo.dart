import 'package:flutter/material.dart';

class Meteo extends StatefulWidget {
  @override
  _MeteoState createState() => _MeteoState();
}

class _MeteoState extends State<Meteo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Météo"),
        ),
      ),
    );
  }
}