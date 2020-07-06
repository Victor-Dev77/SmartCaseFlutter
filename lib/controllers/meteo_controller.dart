import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:smartcaseflutter/models/meteo.dart';

class MeteoController extends GetxController {
  String city = "Paris";
  String apiKey = "bf7e87f71ff5193cd53b3c5e50239287";
  String language = "fr";
  String url = "http://api.openweathermap.org/data/2.5/weather?q=";

  Meteo weather;

  @override
  void onInit() {
    super.onInit();
    url += "$city&appid=$apiKey&units=metric&lang=$language";
    _initWeather();
  }

  _initWeather() async {
    weather = await _getDefaultWeather();
    update();
  }

  Future<Meteo> _getDefaultWeather() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return Meteo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }


}
