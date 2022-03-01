import 'package:flutter/material.dart';
import 'package:world_weather/services/weather_data.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  WeatherData wd = WeatherData();
  String locWarning = '';
  bool locExist = true;
  final tfController = TextEditingController();
  List<String> cities = [
    'Oulu',
    'Helsinki',
    'Beijing',
    'London',
    'New York',
    'Paris',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Choose A Location'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                locWarning,
                style: TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: tfController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Type or select a city',
                ),
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.red,
                ),
              ),
              //SizedBox(height: 20.0,),
              Container(
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: cities.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          tfController.text = cities[index];
                        },
                        title: Text(
                          cities[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                            color: Colors.blue[900 - 100 * index],
                          ),
                        ),
                      );
                    }),
              ),
              RaisedButton(
                  onPressed: () async {
                    locExist = await wd.getWeather(tfController.text);
                    if (locExist) {
                      wd.location = toBeginningOfSentenceCase(
                          wd.location); // First letter in capital.
                      Navigator.pop(context, wd);
                    } else {
                      setState(() {
                        locWarning =
                            'The city name is wrong or its info is not available!';
                      });
                      Timer(Duration(seconds: 2), () {
                        setState(() {
                          locWarning ='';
                          tfController.text = '';
                        });
                      });
                    }
                  },
                  child: Text(
                      'OK',
                    style: TextStyle(
                      fontSize: 30.0,
                      letterSpacing: 2.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
