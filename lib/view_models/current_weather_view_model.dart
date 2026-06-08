import 'dart:convert';

import 'package:appifylab_test/models/current_weather_model.dart';
import 'package:appifylab_test/states/current_weather_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherViewModel extends Notifier<CurrentWeatherState> {
  @override
  build() {
    return CurrentWeatherState();
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services disabled');
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always) {
        position = await Geolocator.getCurrentPosition();
        debugPrint("LAT:${position.latitude} lon: ${position.longitude}");
        return position;
      }

      return Future.error('Location permissions are denied ');
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Locatiion permissions are permanently denied, cannot request',
      );
    }
    position = await Geolocator.getCurrentPosition();
    debugPrint("LAT:${position.latitude} lon: ${position.longitude}");

    return position;
  }

  Future<void> getCurrentWeather() async {
    final position = await _getCurrentLocation();
    final lat = position.latitude;
    final lon = position.longitude;
    debugPrint('api key');
    debugPrint('${dotenv.env['API_Key']}');
    String endpoint =
        'weather?lat=$lat&lon=$lon&appid=${dotenv.env['API_Key']}';

    final url = Uri.parse('${dotenv.env['Base_URL']}$endpoint');
    state = state.copyWith(loadingState: true);
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final tData = jsonDecode(response.body);
      final data = CurrentWeatherModel.fromJSON(tData);
      debugPrint('${data.main.temp}');
      state = state.copyWith(currentWeather: data, loadingState: false);
    } else {
      state = state.copyWith(
        err:
            'Failed to fetch current weather with status code ${response.statusCode}',
        loadingState: false,
      );
    }
  }
}

final currentWeatherViewModelProvider =
    NotifierProvider<CurrentWeatherViewModel, CurrentWeatherState>(() {
      return CurrentWeatherViewModel();
    });
