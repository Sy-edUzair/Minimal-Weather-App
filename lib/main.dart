import 'package:flutter/material.dart';
import 'package:weatherapp/pages/weather_page.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/theme/theme.dart';
import 'package:weatherapp/theme/theme_provider.dart';

//first add packages through terminal i.e flutter pub add http,geolocator,geocoding,lottie(for animations).These will be shown in pubspec.yaml file
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider()..initializeTheme(),
      //Dart has a special cascade operator (..) which allows us to make a sequence of operations on the same object.
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, provider, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const WeatherPage(),

        //this is without consumer widget
        // theme: Provider.of<ThemeProvider>(context).themeData,

        theme: provider.isDarkModeEnabled ? darkMode : lightMode,
        //system dependant theme
        themeMode:
            provider.isDarkModeEnabled ? ThemeMode.dark : ThemeMode.light,
      );
    });
  }
}
