// File name: weather_data.dart
// Define the weather data class.
// The class includes related properties and getWeather function.
// The internet connection check is not implemented here, so if there is
//    no network or WeatherAPI.com is not available, the loading page will keep running.

import 'package:http/http.dart';
import 'dart:convert';

class WeatherData {
  String? location;
  String? country;
  double? temp_c;
  int? is_day;
  String? condition_txt;
  String? condition_icon;
  int? wind;
  String? wind_dir;
  double? precip_mm;
  int? humidity;
  double? feelslike_c;
  double? vis_km;
  double? uv;
  var forecast3Days;

  // API key, Setting your own API KEY
  static const API_KEY = '1bcb74d02904457eb0d145052221802';

  WeatherData(
      {this.location,
      this.country,
      this.temp_c,
      this.is_day,
      this.condition_icon,
      this.condition_txt,
      this.feelslike_c,
      this.humidity,
      this.precip_mm,
      this.uv,
      this.vis_km,
      this.wind,
      this.wind_dir,
      this.forecast3Days});

  // Obtain 3-day weather info from WeatherAPI.com
  // The received json file includes the weather info of current time, 3-day forecast.
  Future getWeather(String loc) async {
    try {
      Uri uri = Uri.parse(
          'http://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=$loc&days=3');

      Response response = await get(uri);
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.

        Map data = jsonDecode(response.body);

        //update class properties.
        location = loc;
        country = data['location']['country'];
        temp_c = data['current']['temp_c'];
        is_day = data['current']['is_day'];
        condition_txt = data['current']['condition']['text'];
        condition_icon = data['current']['condition']['icon'];
        wind = (data['current']['wind_kph'] / 3.6).round();
        wind_dir = data['current']['wind_dir'];
        precip_mm = data['current']['precip_mm'];
        humidity = data['current']['humidity'];
        feelslike_c = data['current']['feelslike_c'];
        vis_km = data['current']['vis_km'];
        uv = data['current']['uv'];

        var row0 = [
          data['forecast']['forecastday'][0]['date'],
          data['forecast']['forecastday'][0]['day']['maxtemp_c'],
          data['forecast']['forecastday'][0]['day']['mintemp_c'],
          data['forecast']['forecastday'][0]['day']['condition']['icon']
        ];
        var row1 = [
          data['forecast']['forecastday'][1]['date'],
          data['forecast']['forecastday'][1]['day']['maxtemp_c'],
          data['forecast']['forecastday'][1]['day']['mintemp_c'],
          data['forecast']['forecastday'][1]['day']['condition']['icon']
        ];
        var row2 = [
          data['forecast']['forecastday'][2]['date'],
          data['forecast']['forecastday'][2]['day']['maxtemp_c'],
          data['forecast']['forecastday'][2]['day']['mintemp_c'],
          data['forecast']['forecastday'][2]['day']['condition']['icon']
        ];
        forecast3Days = [row0, row1, row2];

        return true;
      } else {
        throw Exception('There is wrong in weather info reading');
        //return false;
      }
    } catch (e) {
      return false;
    }
  }
}
