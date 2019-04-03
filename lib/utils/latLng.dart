import 'package:google_maps_flutter/google_maps_flutter.dart';

/// a simple converter for the geolocation, so it would be able to be saved in the database
class LatLngUtil {
  String latLngToString(LatLng geo, double zoom) {
    return geo.latitude.toString() + "," + geo.longitude.toString() + "," + zoom.toString();
  }

  List<dynamic> stringToLatLng(String string) {
    List<String> latLng = string.split(",");
    double latitude = double.parse(latLng[0]);
    double longitude = double.parse(latLng[1]);
    double zoom = double.parse(latLng[2]);
    return [LatLng(latitude, longitude), zoom];
  }
}

final LatLngUtil latLngUtil = LatLngUtil();
