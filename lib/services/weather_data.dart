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

  // API key
  static const API_KEY='1bcb74d02904457eb0d145052221802';

  WeatherData({this.location, this.country, this.temp_c, this.is_day, this.condition_icon, this.condition_txt, this.feelslike_c, this.humidity,
               this.precip_mm, this.uv, this.vis_km, this.wind, this.wind_dir});

  Future getWeather(String loc) async{
    Uri uri = Uri.parse('http://api.weatherapi.com/v1/current.json?key=$API_KEY&q=$loc');

    Response response = await get(uri);
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.

      Map data = jsonDecode(response.body);

      //update class properties.
      location = loc;
      country=data['location']['country'];
      temp_c = data['current']['temp_c'];
      is_day = data['current']['is_day'];
      condition_txt= data['current']['condition']['text'];
      condition_icon = data['current']['condition']['icon'];
      wind = (data['current']['wind_kph']/3.6).round();
      wind_dir = data['current']['wind_dir'];
      precip_mm = data['current']['precip_mm'];
      humidity = data['current']['humidity'];
      feelslike_c = data['current']['feelslike_c'];
      vis_km = data['current']['vis_km'];
      uv = data['current']['uv'];

      print(wind);
      return true;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load json data');
      return false;
    }
  }
}