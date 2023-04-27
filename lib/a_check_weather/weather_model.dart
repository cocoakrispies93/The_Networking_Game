// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'forecast_list.dart';
import 'weather_api.dart';
import 'todays_weather.dart';

class WeatherModel with ChangeNotifier {
  bool isRequestPending = false;
  bool isWeatherLoaded = false;
  bool isRequestError = false;

  final String _city = '';
  final int _zip = 12345; 
  List<Forecast> _dailyForecast = <Forecast>[];
  late final TodaysWeather _currentWeather;
  late PermissionStatus permission;
  late final double positionLat;
  late final double positionLong;

  String get city => _city;
  int get zip => _zip;
  List<Forecast> get dailyForecast => _dailyForecast;
  TodaysWeather get currentWeather => _currentWeather; 

  late WeatherApi weatherApi;

  WeatherModel() {
    weatherApi = WeatherApi();
    _initCurrentWeather();
  }

  Future<void> _initCurrentWeather() async {
    final Location location = Location();
    setRequestPendingState(true);
    isRequestError = false;
    final LocationData locationData = await location.getLocation();
    final double latitude = locationData.latitude!;
    final double longitude = locationData.longitude!;
    try {
      _currentWeather =
          await weatherApi.getCurrentWeatherByLocation(latitude, longitude);
    } catch (e) {
      isRequestError = true;
      return;
    }
    setRequestPendingState(false);
    isRequestError = false;
    notifyListeners();
  }

  Future<void> requestForecast(String city) async {
    setRequestPendingState(true);
    isRequestError = false;

    try {
      // await Future.delayed(Duration(seconds: 1), () => {});
      _dailyForecast = await weatherApi.getForecastList(city);
    } catch (e) {
      isRequestError = true;
    }

    isWeatherLoaded = true;
    setRequestPendingState(false);
    notifyListeners();
  }

  void setRequestPendingState(bool isPending) {
    isRequestPending = isPending;
    notifyListeners();
  }
}
