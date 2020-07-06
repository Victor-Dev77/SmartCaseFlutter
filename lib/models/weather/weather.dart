import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/models/weather/weather_current.dart';
import 'package:smartcaseflutter/models/weather/weather_daily.dart';

class Weather {
  final String urlAPI;
  final String id, city, country;
  final Map location;
  final WeatherCurrent weatherCurrent;
  final List<WeatherDaily> listWeatherDaily;

  Weather({
    @required this.id,
    @required this.city,
    @required this.country,
    @required this.location,
    @required this.weatherCurrent,
    @required this.urlAPI,
    @required this.listWeatherDaily,
  });

  factory Weather.fromDocument(DocumentSnapshot doc) {
    return Weather(
      id: doc['id'],
      city: doc['city'],
      location: doc['location'],
    );
  }

  factory Weather.fromJson(
      Map<String, dynamic> json, String url, String id, String city, String country) {
    return Weather(
      urlAPI: url,
      location: {
        "latitude": json["lat"],
        "longitude": json["lon"],
      },
      city: city,
      country: country,
      id: id,
      weatherCurrent: WeatherCurrent.fromJson(json["current"]),
      listWeatherDaily: List.generate(json['daily'].length, (index) {
        return WeatherDaily.fromJson(json['daily'][index]);
      }),
    );
  }

  //TODO: merge tableau (idUser -> array contains all link api)
  // toMap()
}
