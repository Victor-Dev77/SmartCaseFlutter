import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/date_handle.dart';

class WeatherDaily {

  final String descriptionDaily, dateDaily;
  final int tempDaily;

  WeatherDaily({
    @required this.descriptionDaily,
    @required this.dateDaily,
    @required this.tempDaily,
  });

  factory WeatherDaily.fromJson(Map<String, dynamic> json) {
    return WeatherDaily(
      descriptionDaily: (json['weather'][0])["description"],
      dateDaily: "${DateHandle.to.parseUnix(json["dt"], "E dd")[0].toUpperCase()}${DateHandle.to.parseUnix(json["dt"], "E dd").substring(1)}",
      tempDaily: double.parse("${json["temp"]["day"]}").round(),
    );
  }

}