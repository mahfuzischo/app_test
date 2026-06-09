import 'dart:convert';

import 'package:appifylab_test/models/forecast_model.dart';

import 'package:appifylab_test/states/forecast_state.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class ForecastViewModel extends Notifier<ForecastState> {
  @override
  build() {
    return ForecastState();
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

    return position;
  }

  Future<void> getForecast() async {
    final position = await _getCurrentLocation();
    final lat = position.latitude;
    final lon = position.longitude;

    String endpoint =
        'forecast?lat=$lat&lon=$lon&appid=${dotenv.env['API_Key']}';
    final url = Uri.parse('${dotenv.env['Base_URL']}$endpoint');
    state = state.copyWith(loadingState: true);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final tData = jsonDecode(response.body)['list'] as List;
      print('data:$tData');
      final data = tData.map((e) => ForecastModel.fromJSON(e)).toList();
      debugPrint('forecast data: $data');
      state = state.copyWith(forecast: data, loadingState: false);
    } else {
      state = state.copyWith(
        err:
            'Failed to load forecast data with status code ${response.statusCode}',
        loadingState: false,
      );
    }
  }
}

final forecastViewModelProvider =
    NotifierProvider<ForecastViewModel, ForecastState>(() {
      return ForecastViewModel();
    });
