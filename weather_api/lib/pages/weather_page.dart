import 'package:flutter/material.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/service/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('afff6d02c35346a33bbf5746ff39847b');
  WeatherModel? _weatherModel;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weatherModel = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weatherModel?.cityName ?? "Loading city.."),
            Text("${_weatherModel?.temperature.round()} ^C"),
          ],
        ),
      ),
    );
  }
}
