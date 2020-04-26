import 'package:flutter/material.dart';
import 'package:weather_app/screens/location_page.dart';
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apikey = 'eb5f758d4731d8768ff1157056765023';

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
    Location location = Location();
    await location.getuserlocation();


    NetworkingWeather networkingWeather = NetworkingWeather(
        'https://api.openweathermap.org/data/2.5/weather?lat=${location.latitiude}&lon=${location.longitiude}&units=metric&appid=$apikey');

    var weatherdata = await networkingWeather.getnetworkweather();
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
