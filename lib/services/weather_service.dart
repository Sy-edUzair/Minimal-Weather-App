import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../model/weather_model.dart';
import 'package:http/http.dart' as http;

/*
Future in Flutter refers to an object that represents a value that is not yet available but will be at some point in the future. A Future can be used to represent an asynchronous operation that is being performed, such as fetching data from a web API, reading from a file, or performing a computation.
*/
class WeatherService {
  static const baseUrl = "http://api.openweathermap.org/data/2.5/weather";

  final String apiKey;
  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        .get(Uri.parse('$baseUrl?q=$cityName&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<String> getCurrentCity() async {
    //get location permission access from user
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //extract the city name from the first placemark

    String? city = placemarks[0].locality;

    // if (city == null) {
    //   return "";
    // } else {
    //   return city;
    // }

    //the above code can be replaced with
    return city ?? ""; //the "??" basically means ke whther city is null or not
  }
}
