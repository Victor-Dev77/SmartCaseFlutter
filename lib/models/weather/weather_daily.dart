import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class WeatherDaily {

  final String descriptionDaily, dateDaily;
  final double tempDaily;

  WeatherDaily({
    @required this.descriptionDaily,
    @required this.dateDaily,
    @required this.tempDaily,
  });

  factory WeatherDaily.fromJson(Map<String, dynamic> json) {
    return WeatherDaily(
      descriptionDaily: (json['weather'][0])["description"],
      dateDaily: parseUnix(json["dt"], "dd/MM/yyyy HH:mm"),
      tempDaily: double.parse("${json["temp"]["day"]}"),
    );
  }

}