import 'package:geolocator/geolocator.dart';



class Location{
  double latitiude;
  double longitiude;

  Location({this.latitiude,this.longitiude});

  Future<void> getuserlocation() async {
    try{
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    latitiude = position.latitude;
    longitiude = position.longitude;

    }catch(e)
    {
      print(e);
    }

  }

  

}