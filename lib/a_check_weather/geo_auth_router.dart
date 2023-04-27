// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'forecast_list.dart';
import 'todays_weather.dart';
import 'weather_model.dart';
import '../app_styles/nav_bar_v2.dart';

class GeoAuth extends StatefulWidget {
  const GeoAuth({super.key});

  @override
  State<GeoAuth> createState() => _GeoAuthState();
}

class _GeoAuthState extends State<GeoAuth> {
  bool _locationPermissionGranted = false;
  Widget _appWidget = const SizedBox.shrink();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    // Checking for location permission
    final bool locationPermissionGranted = await _checkLocationPermission();
    setState(() {
      _locationPermissionGranted = locationPermissionGranted;
      // Load the appropriate app based on the user's response!!
      if (_locationPermissionGranted) {
        _appWidget = ChangeNotifierProvider<WeatherModel>(
          create: (_) => WeatherModel(),
          child: permissionApp(
              locationPermissionGranted: _locationPermissionGranted),
        );
      } else {
        _appWidget = ChangeNotifierProvider<WeatherModel>(
          create: (_) => WeatherModel(),
          child: const NoPermissionApp(),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _appWidget;
  }
}

Future<bool> _checkLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
  }
  if (permission == LocationPermission.whileInUse ||
      permission == LocationPermission.always) {
    return true;
  }
  return false;
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Loading...',
      home: Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// ignore: camel_case_types
class permissionApp extends StatelessWidget {
  final bool locationPermissionGranted;
  const permissionApp({super.key, required this.locationPermissionGranted});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          bottom: true,
          child: WeatherViewer(
            locationPermissionGranted: locationPermissionGranted,
          ),
        ),
        bottomNavigationBar: const MyNavigationBar(),
      ),
    );
  }
}

class NoPermissionApp extends StatelessWidget {
  const NoPermissionApp({super.key});

  final bool locationPermissionGranted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        body: SafeArea(
          bottom: true,
          child: WeatherViewer(
              locationPermissionGranted: locationPermissionGranted),
        ),
        bottomNavigationBar: const MyNavigationBar(),
      ),
    );
  }
}

class WeatherViewer extends StatefulWidget {
  final bool locationPermissionGranted;
  const WeatherViewer({super.key, required this.locationPermissionGranted});

  @override
  // ignore: library_private_types_in_public_api
  _WeatherViewerState createState() => _WeatherViewerState();
}

class _WeatherViewerState extends State<WeatherViewer> {
  String cityName = '';
  LatLng? currentPosition;
  final String url = 'https://maps.googleapis.com/maps/api/geocode/';
  final String apiKey = 'API_KEY';

  String _currentLocationStr1 = '';
  bool _isLoading = true;

  late double? positionLat;
  late double? positionLong;

  late String city;
  late String postalCode;
  late String countryName;

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _saveCity(String input) {
    setState(() {
      cityName = input;
    });
  }

  void _queryWeather() {
    Provider.of<WeatherModel>(context, listen: false).requestForecast(cityName);
  }

  Widget _cityInputAndButton() {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Container(
            //width: 300,
            margin: const EdgeInsets.all(5),

            child: TextField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter city'),
              keyboardType: TextInputType.streetAddress,
              onChanged: _saveCity,
              onSubmitted: _saveCity,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _queryWeather,
                  child: const Text(
                    'Fetch Weather and Forecast',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherModel>(
      builder: (context, model, child) => _buildMainTree(model),
    );
  }

  Widget _buildMainTree(WeatherModel model) {
    return Column(
      children: <Widget>[
        _cityInputAndButton(),
        model.isRequestPending
            ? buildBusyIndicator()
            : model.isRequestError
                ? _buildErrorWidget()
                : Expanded(
                    child: Column(
                      children: [
                        if (widget.locationPermissionGranted)
                          _buildCurrentWeatherTile(model.currentWeather),
                        _buildForecastList(model.dailyForecast),
                      ],
                    ),
                  ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return const Center(
      child: Text(
        'Ooops...something went wrong',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    Position position = await Geolocator.getCurrentPosition();

    positionLat = position.latitude;
    positionLong = position.longitude;

    try {
      final response = await http.get(Uri.parse(
          '${url}json?latlng=$positionLat,$positionLong&key=$apiKey'));

      print('inside _getCurrentposition!!!!');

      final jsonData = json.decode(response.body);
      print('past final jsonData');
      final result = jsonData['results'][0];
      print('past final result');
      print('Latitude: $positionLat and Longitude: $positionLong');

      final addressComponents = result['address_components'] as List;
      for (final component in addressComponents) {
        final types = component['types'];
        if (types.contains('locality') as bool) {
          city = component['long_name'] as String;
        } else if (types.contains('postal_code') as bool) {
          postalCode = component['long_name'] as String;
        } else if (types.contains('country') as bool) {
          countryName = component['short_name'] as String;
        }
      }

      setState(() {
        _currentLocationStr1 = '$city, $postalCode, $countryName';
        print('==========================================');
        print('_getCurrentPosition done with setState()');
        print('==========================================');
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      print('*********************************');
      print('_getCurrentPosition threw error');
      print('*********************************');
      _isLoading = false;
    }
  }

  Widget _buildCurrentWeatherTile(TodaysWeather currentWeather) {
    if (_isLoading) {
      // Only display progress indicator when loading is in progress!!
      return const CircularProgressIndicator();
    } else {
      return ListTile(
          title: Text(
            '${currentWeather.temp} ', //temp is temperature
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            '$_currentLocationStr1 feels like '
            '${currentWeather.feelsLike} '
            '${currentWeather.description} ',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.blue,
            ),
          ),
          leading: Image.network(currentWeather.iconURL));
    }
  }

  Widget _buildForecastList(List<Forecast> dailyForecast) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.all(5),
        itemCount: dailyForecast.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.network(dailyForecast[index].iconURL),
              title: Text(
                  '${dailyForecast[index].dayAndHour} ${dailyForecast[index].description}'),
              subtitle: Text(
                // ignore: prefer_interpolation_to_compose_strings
                'Low: ${dailyForecast[index].minTemp} High: ${dailyForecast[index].maxTemp} Humidity: ${dailyForecast[index].humidity}',
                style: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }

  Widget buildBusyIndicator() {
    // ignore: prefer_const_literals_to_create_immutables
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const CircularProgressIndicator(),
      const SizedBox(
        height: 20,
      ),
      const Text('Please Wait...',
          style: TextStyle(
              fontSize: 18, color: Colors.black, fontWeight: FontWeight.w300))
    ]);
  }
}
