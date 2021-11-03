import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:kurs2_sabak8/utilities/constants.dart';
import 'package:kurs2_sabak8/weather_model.dart';

class WeatherProvider {
  Future<WeatherModel> getWeatherModel(
      {String city = '', Position position}) async {
    String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
    String endpointByLocation;
    String endpointByName = 'q=$city&appid=$apiKey';
    if (city == '') {
      endpointByLocation =
          'lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
    }

    String url =
        city == '' ? baseUrl + endpointByLocation : baseUrl + endpointByName;

    // print('url:========= $url');

    Uri uri = Uri.parse(url);

    //Uri
    http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;
      final data = convert.jsonDecode(body) as Map<String, dynamic>;
      // print('Map data: $data');
      // print('Map data temperature: ${data['main']['temp']}');

      final WeatherModel weatherModel = WeatherModel.fromJson(data);
      // print('weatherModel======>: ${weatherModel.cityName}');
      // print('weatherModel======>: ${weatherModel.celcius}');
      // print('weatherModel======>: ${weatherModel.kelvin}');
      // print('weatherModel======>: ${weatherModel.icon}');
      // print('weatherModel======>: ${weatherModel.message}');

      return weatherModel;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> getWeatherData(
      {String city = '', Position position}) async {
    //  https://api.openweathermap.org/data/2.5/weather?q=Bishkek&appid=51c874e49dc37ecae309a5aad34f104f

    String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';
    String endpointByLocation;
    String endpointByName = 'q=$city&appid=$apiKey';
    if (city == '') {
      endpointByLocation =
          'lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';
    }

    String url =
        city == '' ? baseUrl + endpointByLocation : baseUrl + endpointByName;

    Uri uri = Uri.parse(url);

    //Uri
    http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;

      // print('json body: $body');

      final data = convert.jsonDecode(body) as Map<String, dynamic>;
      // print('Map data: ${data['name']}');
      // print('Map data temperature: ${data['main']['temp']}');

      return data;
    } else {
      return null;
    }
  }
}
