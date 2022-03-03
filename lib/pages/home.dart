// File name: home.dart
// Show the home page.
// Display the current weather, or 3 days forecast after clicking the floating button.

import 'package:flutter/material.dart';
import 'package:world_weather/services/weather_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  WeatherData? wd;
  bool weatherToday = true;
  bool on3Days = false;

  // Three days forecast show.
  // The free version of WeatherAPI.com only supplies data of 3 days.
  Widget _threeDays() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: wd?.forecast3Days.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Row(children: [
                    Text(
                      '${wd?.forecast3Days[index][0].substring(5)}',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.red[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Image.network(
                      'https:${wd?.forecast3Days[index][3]}',
                      width: 100.0,
                      height: 100.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${wd?.forecast3Days[index][1]}/${wd?.forecast3Days[index][2]}',
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: Colors.blue[400],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ), //Text(wInDetail[index]),
              );
            }),
      ],
    );
  }

  // Show current weather
  Widget _oneDay() {
    List<String> wInDetail = [
      'FeelsLike: ${wd?.feelslike_c} \u1d52C',
      'Wind: ${wd?.wind} m/s ${wd?.wind_dir}',
      'Precipitation: ${wd?.precip_mm} mm',
      'Humidity: ${wd?.humidity}%',
      'Visibility: ${wd?.vis_km} km',
      'UV: ${wd?.uv!}',
    ];

    List<Text> _transformWord(String word) {
      List<String> name = word.split(' ');
      List<Text> textWidgets = [];
      for (int i = 0; i < name.length; i++) {
        if (name[i].contains(':')) {
          Text bold = Text(
            name[i] + ' ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 20.0,
            ),
          );
          textWidgets.add(bold);
        } else {
          Text normal = Text(
            name[i] + ' ',
            style: TextStyle(
              fontSize: 20.0,
            ),
          );
          textWidgets.add(normal);
        }
      }
      return textWidgets;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Image.network(
              'https:${wd?.condition_icon}',
              width: 150.0,
              height: 150.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 5.0,
            ),
            FlatButton.icon(
              onPressed: () async {
                dynamic ret_wd =
                    await Navigator.pushNamed(context, '/chooseLocation');
                setState(() {
                  wd = ret_wd;
                });
              },
              icon: Icon(Icons.edit_location),
              label: Container(
                width: 150, // change width as you need
                height: 100, // change height as you need
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Text(
                        '${wd?.location} ',
                        textAlign: TextAlign.left,
                        maxLines: 2, // change max line you need
                        style: TextStyle(
                            fontSize: 30.0,
                            letterSpacing: 2.0,
                            color: Colors.red[400]),
                      ),
                      Text(
                        '${wd?.country}',
                        textAlign: TextAlign.left,
                        maxLines: 2, // change max line you need
                        style: TextStyle(
                            fontSize: 20.0,
                            letterSpacing: 2.0,
                            color: Colors.red[800]),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(
          '${wd?.temp_c} \u1d52C, ${wd?.condition_txt} ',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30.0,
            letterSpacing: 2.0,
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        ListView.builder(
            shrinkWrap: true,
            itemCount: wInDetail.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  onTap: () {},
                  title: Wrap(
                    children: _transformWord(wInDetail[index]),
                  ), //Text(wInDetail[index]),
                ),
              );
            }),
      ],
    );
  }

  // Select current weather of 3-day forecast.
  Widget _setWeatherType() {
    if (on3Days)
      return _threeDays();
    else
      return _oneDay();
  }

  @override
  Widget build(BuildContext context) {
    wd = wd != null
        ? wd
        : ModalRoute.of(context)?.settings.arguments as WeatherData;

    // Set a background color for day and night
    Color? bgColor = wd?.is_day == 1 ? Colors.blue[300] : Colors.grey[600];

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.all(10.0), child: _setWeatherType()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              on3Days = !on3Days;
            });
          },
          child: Text(on3Days ? 'Current' : '3 Days',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
