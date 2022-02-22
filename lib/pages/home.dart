import 'package:flutter/material.dart';
import 'package:world_weather/services/weather_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

void receiveData() {

}

class _HomeState extends State<Home> {

  late WeatherData wd;


  @override
  Widget build(BuildContext context) {
    wd=ModalRoute.of(context)?.settings.arguments as WeatherData;
    Color? bgColor=wd.is_day==1?Colors.blue[300]:Colors.grey[600];

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Column(
          children: [
            Image.network(
                'https:${wd.condition_icon}',
              width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0,),
            Text(wd.country!),
          ],
        ),
      ),
    );
  }
}
