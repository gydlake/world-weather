import 'package:flutter/material.dart';
import 'package:world_weather/services/weather_data.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

void receiveData() {}

class _HomeState extends State<Home> {
  late WeatherData wd;

  @override
  Widget build(BuildContext context) {
    wd = ModalRoute.of(context)?.settings.arguments as WeatherData;
    Color? bgColor = wd.is_day == 1 ? Colors.blue[300] : Colors.grey[600];

    List<String> wInDetail = [
      'FeelsLike: ${wd.feelslike_c} \u1d52C, Wind: ${wd.wind} m/s ${wd.wind_dir}',
      'Precipitation: ${wd.precip_mm} mm, Humidity: ${wd.humidity}%',
      'Visibility: ${wd.vis_km} km, UV: ${wd.uv}',
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

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.network(
                      'https:${wd.condition_icon}',
                      width: 150.0,
                      height: 150.0,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    FlatButton.icon(
                      // onPressed: () {},
                      icon: Icon(Icons.edit_location),
                      label: Container(
                        width: 150, // change width as you need
                        height: 100, // change height as you need
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${wd.location} ${wd.country}',
                            textAlign: TextAlign.left,
                            maxLines: 2, // change max line you need
                            style: TextStyle(
                                fontSize: 30.0,
                                letterSpacing: 2.0,
                                color: Colors.red[600]),
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
                  '${wd.temp_c} \u1d52C, ${wd.condition_txt} ',
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
                          title: Row(
                            children: _transformWord(wInDetail[index]),
                          ), //Text(wInDetail[index]),
                        ),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
