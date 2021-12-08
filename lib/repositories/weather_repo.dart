import 'package:kurs2_sabak8/data/providers/location_provider.dart';
import 'package:kurs2_sabak8/data/providers/weather_provider.dart';
import 'package:kurs2_sabak8/models/weather_model.dart';

class WeatherRepo {
  Future<WeatherModel> getWeatherByCurrentLocation() async {
    final _position = await LocationProvider().getCurrentPosition();
    return await WeatherProvider().getWeatherByLocation(_position);
  }

  Future<WeatherModel> getWeatherByCity(String city) async {
    return await WeatherProvider().getWeatherByCity(city);
  }
}

final WeatherRepo weatherRepo = WeatherRepo();



/// MVVM - Model, View, ViewModel
/// UI (View) -> Repo -> Server (Data) ->
/// -> Server (Data, Model) -> Repo -> UI (Screens, Design, Pages, Views)