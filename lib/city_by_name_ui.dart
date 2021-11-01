import 'package:flutter/material.dart';
import 'package:kurs2_sabak8/weather_provider.dart';

class CityByNameUI extends StatefulWidget {
  final String cityName;
  final int temp;
  const CityByNameUI({Key key, this.cityName, this.temp}) : super(key: key);

  @override
  _CityByNameUIState createState() => _CityByNameUIState();
}

class _CityByNameUIState extends State<CityByNameUI> {
  Map<String, dynamic> _cityWeatherData;
  int _celcius = 0;

  @override
  void initState() {
    super.initState();
    getCityWeather();
  }

  Future<void> getCityWeather() async {
    _cityWeatherData =
        await WeatherProvider().getWeatherData(city: widget.cityName);
    _celcius = (_cityWeatherData['main']['temp'] - 273.15).round();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('city by name: ${widget.cityName}'),
            Text('city by name: $_celcius'),
          ],
        ),
      ),
    );
  }
}
