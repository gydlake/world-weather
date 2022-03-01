import 'package:flutter/material.dart';
import 'package:world_weather/services/weather_data.dart';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  WeatherData wd = WeatherData();
  String locWarning= '';
  bool locExist=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Choose A Location'),
      ),
      body: Column(
        children: [
          Text(
            locWarning,
            style: TextStyle(
              fontSize: 30.0,
              letterSpacing: 2.0,
            ),

          ),
          SizedBox(height: 20.0,),
          FlatButton(
              onPressed: () async{
                locExist = await wd.getWeather('Oulu');
                if (locExist)
                  Navigator.pop(context, wd);
                else {
                  setState(() {
                    locWarning= 'The city cannot be accessed!';
                  });

                }


              },
              child: Text('OK'))
         ],
      ),
    );
  }
}
