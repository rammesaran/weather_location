import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/screens/location_page.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';


class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  @override
  void initState() {
    super.initState();
    getlocation();
  }

  void getlocation() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherdata = await weatherModel.getLocationWeather();
    
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return LocationScreen(
         locationscreen: weatherdata
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCircle(
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                color: index.isEven ? Colors.red : Colors.green,
              ),
            );
          },
        ),
      ),
    );
  }
}
