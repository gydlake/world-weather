import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  // API key
  static const YOUR_API_KEY='79998d3baee4422c9b4143406221802';



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();

  }

  //http.Response response= await http.get(Uri.parse('https://yahoo-weather5.p.rapidapi.com/weather?location=oulu,fi&format=json&u=f'), headers: _headers);
  // Base API request to get response

  void getData()  async {

      Uri uri = Uri.parse('http://api.weatherapi.com/v1/current.json?key=1bcb74d02904457eb0d145052221802&q=London');
      //Uri uri = Uri.https(_baseUrl, endpoint, query);

      Response response = await get(uri);
      if (response.statusCode == 200) {
        // If server returns an OK response, parse the JSON.
        print('ttt');
          Map data = jsonDecode(response.body);
          print(data);
      } else {
        // If that response was not OK, throw an error.
        throw Exception('Failed to load json data');
      }

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
