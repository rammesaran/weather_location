import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkingWeather{
NetworkingWeather(this.url);
final String url;

Future getnetworkweather()async
{
    http.Response response = await http.get(url);
    if(response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
}
else{
  print(response.statusCode);

} 
}
}