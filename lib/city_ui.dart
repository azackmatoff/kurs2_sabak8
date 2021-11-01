import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurs2_sabak8/circular_progress.dart';
import 'package:kurs2_sabak8/city_by_name_ui.dart';
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();
  Position _position;
  Map<String, dynamic> _data;
  int _celcius = 0;
  String _cityName;

  @override
  void initState() {
    super.initState();
    //kodtor astinda jazilish kerke
    // getCurrentLocation();
    // showSnackbar();
    // _showMyDialog();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showMyDialog();
    // });

    print('initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //kodtor astinda jazilish kerke
    getCurrentLocation();
    // showSnackbar();
    //contest aluu uchun kutkonu jardam beret
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showMyDialog();
    // });

    print('didChangeDependencies');
  }

  Future<void> getCurrentLocation() async {
    _position = await LocationProvider().getCurrentPosition();

    _data = await WeatherProvider().getWeatherData(position: _position);

    double _kelvin = _data['main']['temp'];

    _cityName = _data['name'];

    _celcius = (_kelvin - 273.15).round();

    print('_position.lat: ${_position.latitude}');
    print('_position.long: ${_position.longitude}');

    await Future.delayed(Duration(seconds: 1), () {});
    setState(() {});
  }

  void showSnackbar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: const Text('snack'),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'ACTION',
        onPressed: () {},
      ),
    ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Write your city'),
          content: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Required field';
                  } else {
                    return null;
                  }
                },
                onChanged: (String danniy) {
                  // print('onChanged: $danniy');
                  // // _cityName = danniy;
                  // print('onChanged _cityName: $_cityName');
                },
                controller: _cityNameController,
                // onSaved: (String danniy) {
                //   print('validate');
                //   print('onSaved: $danniy');
                //   _cityName = danniy;
                // },
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                print(
                    '_cityNameController.text before validate: ${_cityNameController.text}');
                if (_formKey.currentState.validate()) {
                  print(
                      '_cityNameController.text after validate: ${_cityNameController.text}');
                  Navigator.of(context).pop(); //Dialogtu jap
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CityByNameUI(
                        cityName: _cityNameController.text,
                        temp: _celcius, //bul jon gana misal uchun
                      ),
                    ),
                  );
                }
                //Jani betke ot
              },
            ),
          ],
        );
      },
    );
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
          : Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                leading: Icon(Icons.near_me),
                actions: [
                  GestureDetector(
                    onTap: _showMyDialog,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12.0),
                      child: Icon(Icons.location_city),
                    ),
                  ),
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('City: $_cityName'), //Shaar aty versiya 1
                    Text('City: ${_data['name']}'), //Shaar aty versiya 2
                    Text('Temperature F: ${_data['main']['temp']}'),
                    Text('Temperature C: $_celcius'),
                    // Text('Latitude: ${_position.latitude}'),
                    // Text('Latitude: ${_position.latitude}'),
                    // Text('Longitude: ${_position.longitude}'),
                    // Text('Longitude: ${_position.longitude}'),
                    // TextButton(
                    //   onPressed: _showMyDialog,
                    //   child: Text('snackbar'),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
