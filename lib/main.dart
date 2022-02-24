import 'package:flutter/material.dart';
import 'package:world_weather/pages/loading.dart';
import 'package:world_weather/pages/home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/loading',
    routes: {
      '/loading': (context) => Loading(),
      '/home': (context) => Home(),
    },
  ));
}
