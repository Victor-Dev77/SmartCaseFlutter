import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartcaseflutter/utils/functions.dart';

class Meteo {
  final String id, name, description, date, country, sunrise, sunset;
  final Map location, wind;
  final double tempAVG, tempMIN, tempMAX;


  Meteo({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.date,
    @required this.country,
    @required this.sunrise,
    @required this.sunset,
    @required this.location,
    @required this.wind,
    @required this.tempAVG,
    @required this.tempMIN,
    @required this.tempMAX,
  });

  factory Meteo.fromDocument(DocumentSnapshot doc) {
    return Meteo(
        id: doc['id'],
        name: doc['name'],
        description: doc['description'],
        date: parseDateTime(doc["date"].toDate(), "dd/MM/yyyy HH:mm"),
        country: doc['country'],
        sunrise: doc['sunrise'],
        sunset: doc['sunset'],
        location: doc['location'],
        wind: doc['wind'],
        tempAVG: doc['temperature']["tempAVG"],
        tempMIN: doc['temperature']['tempMIN'],
        tempMAX: doc['temperature']['tempMAX'],
    );
  }

  factory Meteo.fromJson(Map<String, dynamic> json) {
    return Meteo(
        id: "${json['id']}",
        name: json['name'],
        description: (json['weather'][0])["description"],
        date: parseUnix(json["dt"], "dd/MM/yyyy HH:mm"),
        country: json['sys']["country"],
        sunrise: parseUnix(json['sys']["sunrise"], "dd/MM/yyyy HH:mm"),
        sunset: parseUnix(json['sys']["sunset"], "dd/MM/yyyy HH:mm"),
        location: {
          "latitude": json['coord']["lat"],
          "longitude": json['coord']["lon"],
        },
        wind: json["wind"],
        tempAVG: double.parse("${json["main"]["temp"]}"),
        tempMIN: double.parse("${json["main"]["temp_min"]}"),
        tempMAX: double.parse("${json["main"]["temp_max"]}"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "date": parseDateString(date, "dd/MM/yyyy HH:mm"),
      "country": country,
      "sunrise": sunrise,
      "sunset": sunset,
      "location": location,
      "wind": wind,
      "temperature": {
        "tempAVG": tempAVG,
        "tempMIN": tempMIN,
        "tempMAX": tempMAX,
      }
    };
  }
}
