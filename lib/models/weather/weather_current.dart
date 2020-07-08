import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/date_handle.dart';

class WeatherCurrent {

  final String description, date;
  final int temperature, windSpeed, indiceUV, humidity;

  WeatherCurrent({
    @required this.description,
    @required this.date,
    @required this.temperature,
    @required this.indiceUV,
    @required this.humidity,
    @required this.windSpeed,
  });

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      description: (json['weather'][0])["description"],
      date: DateHandle.to.parseUnix(json["dt"], "dd/MM/yyyy HH:mm"),
      temperature: double.parse("${json["temp"]}").round(),
      indiceUV: double.parse("${json["uvi"]}").round(),
      humidity: double.parse("${json["humidity"]}").round(),
      windSpeed: (double.parse("${json["wind_speed"]}") * 3.6).round(), //m/s -> km/h
    );
  }

}