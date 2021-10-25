import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:kurs2_sabak8/utilities/constants.dart';

class WeatherProvider {
  Future<Map<String, dynamic>> getWeatherData(
      String city, bool isLocation, Position position) async {
    //  https://api.openweathermap.org/data/2.5/weather?q=Bishkek&appid=51c874e49dc37ecae309a5aad34f104f

    String baseUrl = 'https://api.openweathermap.org/data/2.5/weather?';

    String endpointByName = 'q=$city&appid=$apiKey';
    String endpointByLocation =
        'lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey';

    String url =
        isLocation ? baseUrl + endpointByLocation : baseUrl + endpointByName;

    Uri uri = Uri.parse(url);

    //Uri
    http.Response response = await http.get(uri);
    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = response.body;

      print('body: $body');

      final data = convert.jsonDecode(body) as Map<String, dynamic>;
      print('data: $data');

      return data;
    } else {
      return null;
    }
  }
}
