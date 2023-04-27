

//=======================================
//  Original Geo Auth had Main function
//=======================================

//import 'package:location/location.dart';
//import 'package:geocode/geocode.dart';
//import '../app_styles/nav_bar.dart';

/*
void main() async {
  // Show the loading screen while checking for location permission
  runApp(const LoadingScreen());

  // Check for location permission
  bool locationPermissionGranted = await _checkLocationPermission();

  // Load the appropriate app based on the user's response
  if (locationPermissionGranted) {
    runApp(
      ChangeNotifierProvider<WeatherModel>(
        create: (_) => WeatherModel(),
        child:
            permissionApp(locationPermissionGranted: locationPermissionGranted),
      ),
    );
  } else {
    runApp(
      ChangeNotifierProvider<WeatherModel>(
        create: (_) => WeatherModel(),
        child: const noPermissionApp(),
      ),
    );
  }
}
*/


//=======================================
//      Weather Model Extra Shit
//=======================================

//import 'package:geolocator/geolocator.dart';
//import 'package:weather/weather.dart';

    // Initialize current weather using device's location

    //Position position = await Geolocator.getCurrentPosition();
    //GeoCode geoCode = GeoCode();

    //positionLat = position.latitude;
    //positionLong = position.longitude;

        //bool serviceEnabled;

    // Get device's location

