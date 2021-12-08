import 'package:kurs2_sabak8/utilities/weather_util.dart';

class WeatherModel {
  final String cityName;
  final double kelvin;
  final int celcius;
  final String icon;
  final String message;
  // final int saat;
  // final int minute;

  WeatherModel({
    this.cityName,
    this.kelvin,
    this.celcius,
    this.icon,
    this.message,
    // this.saat,
    // this.minute,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['name'],
        kelvin: json['main']['temp'],
        celcius: WeatherUtil.kelvinToCelcius(json['main']['temp']),
        icon: WeatherUtil.getWeatherIcon((json['main']['temp']).round()),
        message: WeatherUtil.getWeatherMessage(
            WeatherUtil.kelvinToCelcius(json['main']['temp'])),
      );
}
