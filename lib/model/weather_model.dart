import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
const apikey = 'eb5f758d4731d8768ff1157056765023';
const weatherurl = 'https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
Future<dynamic> getinputlocation(String cityname) async
{
  var url ='$weatherurl?q=$cityname&appid=$apikey&units=metric';
  NetworkingWeather weather =  NetworkingWeather(url);
  var weatherresult = await weather.getnetworkweather();
  return weatherresult;
}

Future<dynamic> getLocationWeather() async
{
  Location location = Location();
    await location.getuserlocation();


    NetworkingWeather networkingWeather = NetworkingWeather(
        '$weatherurl?lat=${location.latitiude}&lon=${location.longitiude}&units=metric&appid=$apikey');

    var weatherdata = await networkingWeather.getnetworkweather();
    return weatherdata;
}

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}