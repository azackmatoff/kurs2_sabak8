import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kurs2_sabak8/constants/app_text_styles.dart';
import 'package:kurs2_sabak8/repositories/weather_repo.dart';

import 'package:kurs2_sabak8/screens/city_by_name_screen.dart';
import 'package:kurs2_sabak8/data/providers/location_provider.dart';
import 'package:kurs2_sabak8/widgets/progress_indicator.dart';
import 'package:kurs2_sabak8/screens/city_screen.dart';

import 'package:kurs2_sabak8/models/weather_model.dart';
import 'package:kurs2_sabak8/data/providers/weather_provider.dart';

//Flutter StatefulWidget lifecycle
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cityNameController = TextEditingController();
  Position _position;

  bool isLoading = false;
  Map<String, dynamic> _data;
  int _celcius = 0;
  String _cityName;
  String weatherIcon;
  String weatherMessage;

  WeatherModel weatherModel;

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
    getWeatherByCurrentLocation();
    // showSnackbar();
    //contest aluu uchun kutkonu jardam beret
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _showMyDialog();
    // });

    print('didChangeDependencies');
  }

  Future<void> getWeatherByCurrentLocation() async {
    setState(() {
      isLoading = true;
    });

    weatherModel = await weatherRepo.getWeatherByCurrentLocation();

    setState(() {
      isLoading = false;
    });
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
                      builder: (context) => CityByNameScreen(
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
      body: Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: isLoading
              ? circularProgress()
              : SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () async {
                              getWeatherByCurrentLocation();
                            },
                            child: Icon(
                              Icons.near_me,
                              size: 50.0,
                            ),
                          ),
                          FlatButton(
                            onPressed: () async {
                              // _showMyDialog();
                              String typedCity = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return CityScreen();
                                  },
                                ),
                              );

                              if (typedCity != null) {
                                setState(() {
                                  isLoading = true;
                                });
                                weatherModel = await weatherRepo
                                    .getWeatherByCity(typedCity);

                                await Future.delayed(Duration(seconds: 1));

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Icon(
                              Icons.location_city,
                              size: 50.0,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              '${weatherModel.celcius}',
                              style: AppTextStyles.tempTextStyle,
                            ), //Model menen ishtegen
                            // Text(
                            //   '$_celcius',
                            //   style: kTempTextStyle,
                            // ),  //Model jasabay tuz ishtoo
                            Text(
                              weatherModel.icon ?? '??????',
                              style: AppTextStyles.conditionTextStyle,
                            ), //Model mn ishtoo
                            // Text(
                            //   weatherIcon ?? '??????',
                            //   style: kConditionTextStyle,
                            // ),//Model jok ishtoo
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 15.0),
                        child: Text(
                          weatherModel.message == null
                              ? 'Weather in ${weatherModel.cityName}'
                              : '${weatherModel.message} in ${weatherModel.cityName}',
                          textAlign: TextAlign.right,
                          style: AppTextStyles.messageTextStyle,
                        ),
                        // Text(
                        //   weatherMessage == null
                        //       ? 'Weather in $_cityName'
                        //       : '$weatherMessage in $_cityName',
                        //   textAlign: TextAlign.right,
                        //   style: kMessageTextStyle,
                        // ), //Model jok ishtoo
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}


//OOP Object Oriented Programming language

//Model 
//Class



//  Future<void> getCurrentLocationV1() async {
//     setState(() {
//       isLoading = true;
//     });
//     _position = await LocationProvider().getCurrentPosition();

//     _data = await WeatherProvider().getWeatherData(position: _position);

//     weatherModel = await WeatherProvider().getWeatherModel(position: _position);

//     double _kelvin = _data['main']['temp'];

//     _cityName = _data['name'];

//     _celcius = (_kelvin - 273.15).round();

//     // print('_position.lat: ${_position.latitude}');
//     // print('_position.long: ${_position.longitude}');

//     await Future.delayed(Duration(seconds: 1), () {});

//     setState(() {
//       isLoading = false;
//     });
//   }