import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/model/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:weatherapp/utilities/drawer_widget.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //apikey
  final _weatherService = WeatherService('429992622d35f612d2d929e883655467');
  Weather? _weather;
  //fetch Weather
  fetchWeather() async {
    //get city
    String cityName = await _weatherService.getCurrentCity();
    //get weather
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(
        () {
          _weather = weather;
        },
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  //weather animations
  String getWeatherAnimation(String? mainWeather) {
    if (mainWeather == null) {
      return 'animations/sunny.json';
    }
    switch (mainWeather.toLowerCase()) {
      case 'clouds':
      case 'cloudy':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'smog':
        return 'animations/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'light shower':
        return 'animations/rainy.json';
      case 'thunderstorm':
      case 'lightning':
        return 'animations/thunder.json';
      case 'clear':
      case 'sunny':
      case 'clear sky':
        return 'animations/sunny.json';
      default:
        return 'animations/sunny.json';
    }
  }

  //init state
  @override
  void initState() {
    super.initState();
    //fetch weather on startup
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        // actions: [
        //   Switch(
        //     value: Provider.of<ThemeProvider>(context).isDarkModeEnabled,
        //     onChanged: (value) {
        //       if (value) {
        //         Provider.of<ThemeProvider>(context, listen: false)
        //             .setDarkTheme();
        //       } else {
        //         Provider.of<ThemeProvider>(context, listen: false)
        //             .setLightTheme();
        //       }
        //     },
        //   ),
        // ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: Icon(Icons.cloud_circle, size: 100),
            ),
            DrawerWidget(),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _weather?.cityName ?? "loading city...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Text(", "),
                Text(
                  _weather?.country ?? "loading country...",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),

            //animations
            Lottie.asset(getWeatherAnimation(_weather?.mainWeather)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${_weather?.temperature.round()} °C',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 20),
                Text(
                  _weather?.mainWeather ?? "",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


//we need to add permissions in android xml file and ios runner(info.plist) file to actually make the API work