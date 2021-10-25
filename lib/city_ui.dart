import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurs2_sabak8/circular_progress.dart';
import 'package:kurs2_sabak8/location_provider.dart';
import 'package:kurs2_sabak8/progress_indicator.dart';
import 'package:kurs2_sabak8/weather_provider.dart';

//Flutter StatefulWidget lifecycle
class CityUI extends StatefulWidget {
  const CityUI({Key key}) : super(key: key);

  @override
  _CityUIState createState() => _CityUIState();
}

class _CityUIState extends State<CityUI> {
  Position _position;

  @override
  void initState() {
    super.initState();
    //kodtor astinda jazilish kerke
    print('initState');

    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    _position = await LocationProvider().getCurrentPosition();

    WeatherProvider().getWeatherData('Osh', _position != null, _position);

    print('_position.lat: ${_position.latitude}');
    print('_position.long: ${_position.longitude}');

    await Future.delayed(Duration(seconds: 3), () {});
    setState(() {});
  }

  @override
  void dispose() {
    //kodtor ustundo jazilish kerek
    print('dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    //kodtor ustundo jazilish kerek
    print('deactivate');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return Scaffold(
      body: _position == null
          ? circularProgress()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Latitude: ${_position.latitude}'),
                  Text('Longitude: ${_position.longitude}'),
                ],
              ),
            ),
    );
  }
}
