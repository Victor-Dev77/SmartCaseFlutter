import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcaseflutter/models/weather/weather.dart';
import 'package:smartcaseflutter/utils/snackbar.dart';

class WeatherController extends GetxController {

  static WeatherController get to => Get.find(); 

  String city = "Paris";
  String apiKey = "bf7e87f71ff5193cd53b3c5e50239287";
  String language = "fr";
  String hostCurrent = "http://api.openweathermap.org/data/2.5/weather?q=";
  String hostWeatherDaily = "https://api.openweathermap.org/data/2.5/onecall?";
  String endURL = "";

  Weather weather;
  bool searchOpen = false;
  TextEditingController cityController = TextEditingController();
  String _tempCity;
  Weather _tempWeather;

  @override
  void onInit() {
    super.onInit();
    _initWeather();
    _composeURL();
  }

  _initWeather() async {
    weather = await _composeURL();
    cityController.text = "";
    update();
  }

  //TODO: a decouper en plusieurs fonctions
  Future<Weather> _composeURL() async {
    endURL = "&appid=$apiKey&units=metric&lang=$language";
    String urlForGetCoordWithCity = hostCurrent + city + endURL;
    var client = http.Client();
    try {
      var responseCoord = await client.get(urlForGetCoordWithCity);
      if (responseCoord.statusCode == 200) {
        Map<String, dynamic> data = json.decode(responseCoord.body);
        var lat = "${data['coord']["lat"]}";
        var lon = "${data['coord']["lon"]}";
        var city = data['name'];
        var country = data["sys"]["country"];
        var id = "${data['id']}";
        String finalURL = hostWeatherDaily + "lat=$lat&lon=$lon&exclude=minutely,hourly" + endURL; 
        var responseWeather = await client.get(finalURL);
        if (responseWeather.statusCode == 200) {
          return Weather.fromJson(json.decode(responseWeather.body), finalURL, id, city, country);
        } else {
          throw Exception('Failed to load weather daily');
        }
      } else {
        CustomSnackbar.snackbar("Ville erronée !");
        city = _tempCity;
        weather = _tempWeather;
        return weather;
      }
    } finally {
      client.close();
    }
  }

  searchCity() {
    if (!searchOpen) {
      searchOpen = true;
      update();
      return;
    }
    if (cityController.text.trim().length <= 3 || city == cityController.text.trim())
      return;
    _tempWeather = weather;
    _tempCity = city;
    city = cityController.text.trim();
    _initWeather();
  }
}
