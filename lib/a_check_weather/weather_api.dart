// ignore_for_file: avoid_print
import 'dart:convert';
import "package:http/http.dart" as http;
import 'forecast_list.dart';
import 'todays_weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

class WeatherApi {
  static const endPointUrl = 'https://api.openweathermap.org/data/2.5';
  static const apiKey =
      'API_KEY';
  late http.Client httpClient;

  WeatherApi() {
    httpClient = http.Client();
  }

  //===========================
  //    Forecast List
  //===========================
  Future<List<Forecast>> getForecastList(String city) async {
    List<Forecast> dailyList = <Forecast>[];
    final requestUrl = '$endPointUrl/forecast?q=$city&appid=$apiKey';
    print('${Uri.parse(Uri.encodeFull(requestUrl))}');
    final response =
        await httpClient.get(Uri.parse(Uri.encodeFull(requestUrl)));
    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }
    dynamic items = jsonDecode(response.body)['list'];
    dailyList = items.map<Forecast>((item) => Forecast.fromJson(item)).toList()
        as List<Forecast>;
    return dailyList; //This is an entire list
  }

  //===========================
  //    Today's Weather
  //===========================
  Future<TodaysWeather> getCurrentWeather(String city) async {
    final requestUrl = '$endPointUrl/weather?q=$city&appid=$apiKey';
    print('${Uri.parse(Uri.encodeFull(requestUrl))}');

    final response =
        await httpClient.get(Uri.parse(Uri.encodeFull(requestUrl)));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return TodaysWeather.fromJson(jsonDecode(response.body));
  }

  Future<TodaysWeather> getCurrentWeatherByLocation(
      double lat, double long) async {
    final requestUrl = '$endPointUrl/weather?lat=$lat&lon=$long&appid=$apiKey';
    print('${Uri.parse(Uri.encodeFull(requestUrl))}');

    final response =
        await httpClient.get(Uri.parse(Uri.encodeFull(requestUrl)));

    if (response.statusCode != 200) {
      throw Exception('error retrieving weather: ${response.statusCode}');
    }

    return TodaysWeather.fromJson(jsonDecode(response.body));
  }
}
