import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_weather/services/weather_data.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {


  WeatherData wd = WeatherData();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   setWeather();


  }

  void setWeather() async{
    await wd.getWeather('Helsinki');
    print(wd.country);
    Navigator.pushReplacementNamed(context, '/home', arguments: wd);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Loading'),
            SizedBox(height: 30.0),
            
          ],
        ),
      ),
    );
  }
}
