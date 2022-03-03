// File Name main.dart
// main function
// routes are used to navigate software to another page/class
// 2022-03-03, Oulu, Finland

import 'package:flutter/material.dart';
import 'package:world_weather/pages/choose_location.dart';
import 'package:world_weather/pages/loading.dart';
import 'package:world_weather/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute:
        '/loading', // First go to loading page to read data from WeatherAPI.com
    routes: {
      '/loading': (context) => Loading(),
      '/home': (context) => Home(), // To home page
      '/chooseLocation': (context) => ChooseLocation(), // To  choose a new city
    },
  ));
}
