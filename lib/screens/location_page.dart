import 'package:flutter/material.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/screens/city_page.dart';
import 'package:weather_app/utilities/constant.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationscreen});
  final locationscreen;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  int temparture;
  String weatherIcon;
  String description;
  String cityname;

  @override
  void initState() {
    super.initState();
    updateWeater(widget.locationscreen);
  }

  void updateWeater(dynamic weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temparture = 0;
        weatherIcon = 'error';
        description = 'unable to get data';
        cityname = '';
        return;
      }
      double temp = weatherdata['main']['temp'];
      temparture = temp.toInt();

      var condition = weatherdata['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition);

      description = weatherModel.getMessage(temparture);

      cityname = weatherdata['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var locationdata =
                          await weatherModel.getLocationWeather();
                      updateWeater(locationdata);
                      print('iam tapped');
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                     var getweather=  await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {

                          return CityPage();
                        }),
                      );
                        if(getweather != null)
                        {
                          var weatherdata = await weatherModel.getinputlocation(getweather);
                          updateWeater(weatherdata);
                        }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 15.0,
                ),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        temparture.toString(),
                        style: kTempTextStyle,
                      ),
                    ),
                    Text(
                      weatherIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$description in $cityname",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// var temperature = jsonDecode(data)['main']['temp'];
// var condition = jsonDecode(data)['weather'][0]['id'];

// var cityname = jsonDecode(data)['name'];
