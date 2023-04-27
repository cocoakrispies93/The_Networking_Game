import 'package:intl/intl.dart';

class TodaysWeather {
  final String name;
  final String dayAndHour;
  final String temp;
  final String feelsLike;
  final String humidity;
  final String description;
  final String clouds;
  final String iconURL;

  TodaysWeather({
    required this.name,
    required this.dayAndHour,
    required this.temp,
    required this.feelsLike,
    required this.humidity,
    required this.clouds,
    required this.description,
    required this.iconURL,
  });

  static TodaysWeather fromJson(dynamic json) {
    // get the local date and time from json
    var dateTime = DateTime.fromMillisecondsSinceEpoch(json['dt'] * 1000 as int,
        isUtc: false);

    return TodaysWeather(
      name: json['name'].toString(),
      dayAndHour: DateFormat('EEEE, h:mm a').format(dateTime).toString(),
      temp: "${((json['main']['temp'] - 273.15) * 9 / 5 + 32).round()}\u00B0F",
      feelsLike:
          "${((json['main']['feels_like'] - 273.15) * 9 / 5 + 32).round()}\u00B0F",
      humidity: json['main']['humidity'].toString(),
      clouds: json['clouds']['all'].toString(),
      description: json['weather'][0]['description'].toString(),
      iconURL: 'http://openweathermap.org/img/w/' +
          json['weather'][0]['icon'].toString() +
          '.png'.toString(),
    );
  }
}
