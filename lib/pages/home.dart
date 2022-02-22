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
                    SizedBox(width: 20.0,),
                    FlatButton.icon(
                      onPressed: (){},
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
                                color: Colors.red[600]
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),

                SizedBox(height: 20.0,),
                Text(
                  '${wd.temp_c}\u1d52C, ${wd.condition_txt} ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'FeelsLike: ${wd.feelslike_c}\u1d52C, Wind: ${wd.wind}${wd.wind_dir}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'Precipitation: ${wd.precip_mm}, Humidity: ${wd.humidity}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.0,),
                Text(
                  'Visibility in Km: ${wd.vis_km}, UV: ${wd.uv}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                    color: Colors.white,
                  ),
                ),
              ],
          ),
            ),
        ),
      ),
    );
  }
}
