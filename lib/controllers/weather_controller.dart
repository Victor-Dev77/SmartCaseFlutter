import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcaseflutter/models/weather/weather.dart';

class WeatherController extends GetxController {
  String city = "Paris";
  String apiKey = "bf7e87f71ff5193cd53b3c5e50239287";
  String language = "fr";
  String hostCurrent = "http://api.openweathermap.org/data/2.5/weather?q=";
  String hostWeatherDaily = "https://api.openweathermap.org/data/2.5/onecall?";
  String endURL = "";

  Weather weather;

  @override
  void onInit() {
    super.onInit();
    _initWeather();
    _composeURL();
  }

  _initWeather() async {
    weather = await _composeURL();
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
        throw Exception('Failed to load weather coord');
      }
    } finally {
      client.close();
    }
  }
}
