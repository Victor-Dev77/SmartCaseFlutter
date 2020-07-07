import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smartcaseflutter/models/weather/weather.dart';
import 'package:smartcaseflutter/models/weather/weather_daily.dart';

class WeatherUI extends StatelessWidget {
  final Weather weather;
  WeatherUI(this.weather);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff293251),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          _buildImageDesc(),
          _buildDescAndTemp(),
          _buildMoreInfo(),
          _buildLocation(),
        ],
      ),
    );
  }

  Widget _buildImageDesc() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Center(
          child: Icon(
            _handleWeatherDescription(weather.weatherCurrent.description),
            color: Color(0xff80BFFD),
            size: 125,
          ),
        ),
      ),
    );
  }

  Widget _buildDescAndTemp() {
    return Expanded(
      child: Column(
        children: <Widget>[
          RichText(
            text: TextSpan(
              text: "${weather.weatherCurrent.temperature}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: "° c",
                  style: TextStyle(fontWeight: FontWeight.normal),
                )
              ],
            ),
          ),
          SizedBox(height: 5),
          Text(
            "${weather.city.toUpperCase()}, ${weather.country}\n${weather.weatherCurrent.description}",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreInfo() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _buildCurrentWind(),
            ),
            Expanded(
              flex: 3,
              child: _buildCurrentPreception(),
            ),
            Expanded(
              flex: 2,
              child: _buildCurrentHumidity(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentWind() {
    return Container(
      margin: EdgeInsets.only(right: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        color: Color(0xff384366),
      ),
      child: _currentWeatherInfo(
          "${weather.weatherCurrent.windSpeed}", FontAwesomeIcons.wind, "Vent"),
    );
  }

  Widget _currentWeatherInfo(String value, IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          value,
          style: TextStyle(
              color: Color(0xff80BFFD),
              fontWeight: FontWeight.bold,
              fontSize: 30),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 7),
          child: Icon(icon, color: Colors.grey[300]),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey[300], fontSize: 16),
        )
      ],
    );
  }

  Widget _buildCurrentPreception() {
    return Container(
      margin: EdgeInsets.only(right: 3),
      color: Color(0xff384366),
      child: _currentWeatherInfo("${weather.weatherCurrent.indiceUV}",
          FontAwesomeIcons.sun, "Indice UV"),
    );
  }

  Widget _buildCurrentHumidity() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        color: Color(0xff384366),
      ),
      child: _currentWeatherInfo("${weather.weatherCurrent.humidity}",
          FontAwesomeIcons.cloudRain, "Humidité"),
    );
  }

  Widget _buildLocation() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xff384366),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView.builder(
            itemCount: weather.listWeatherDaily.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (ctx, index) {
              return _buildDailyWeather(weather.listWeatherDaily[index]);
            }),
      ),
    );
  }

  _buildDailyWeather(WeatherDaily weather) {
    return Container(
        width: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              weather.dateDaily,
              style: TextStyle(
                  color: Colors.grey[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 13),
              child: Icon(_handleWeatherDescription(weather.descriptionDaily),
                  color: Color(0xff80BFFD)),
            ),
            Text(
              "${weather.tempDaily}°c",
              style: TextStyle(color: Colors.grey[300], fontSize: 16),
            ),
          ],
        ));
  }

  IconData _handleWeatherDescription(String desc) {
    if (desc.contains("ciel dégagé") || desc.contains("peu nuageux"))
      return FontAwesomeIcons.cloudSun;
    else if (desc.contains("nuageux"))
      return FontAwesomeIcons.cloud;
    else if (desc.contains("légère pluie"))
      return FontAwesomeIcons.cloudSunRain;
    return FontAwesomeIcons.sun;
  }
}
