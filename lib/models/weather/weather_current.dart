import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class WeatherCurrent {

  final String description, date;
  final double temperature;
  final int windSpeed, indiceUV, humidity;

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
      date: parseUnix(json["dt"], "dd/MM/yyyy HH:mm"),
      temperature: double.parse("${json["temp"]}"),
      indiceUV: double.parse("${json["uvi"]}").round(),
      humidity: double.parse("${json["humidity"]}").round(),
      windSpeed: (double.parse("${json["wind_speed"]}") * 3.6).round(), //m/s -> km/h
    );
  }

}