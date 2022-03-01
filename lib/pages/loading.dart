import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:world_weather/services/weather_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  void setWeather() async {
    await wd.getWeather('Helsinki');
    //print(wd.country);
    Navigator.pushReplacementNamed(context, '/home', arguments: wd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Loading',
              style: TextStyle(
                  fontSize: 40.0, letterSpacing: 2.0, color: Colors.red[600]),
            ),
            SizedBox(height: 30.0),
            SpinKitFadingCircle(
              color: Colors.blue,
              size: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
