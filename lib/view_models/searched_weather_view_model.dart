import 'dart:convert';

import 'package:appifylab_test/models/searched_city_model.dart';
import 'package:appifylab_test/models/searched_weather_model.dart';

import 'package:appifylab_test/states/searched_weather_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:http/http.dart' as http;

class SearchedWeatherViewModel extends Notifier<SearchedWeatherState> {
  @override
  build() {
    return SearchedWeatherState();
  }

  Future<void> getCitytWeather(String city) async {
    String endpoint1 = 'weather?q=$city&appid=${dotenv.env['API_Key']}';
    final url1 = Uri.parse('${dotenv.env['Base_URL']}$endpoint1');
    state = state.copyWith(loadingState: true, searched: true);

    final searchedCityLoc = await http.get(url1);

    if (searchedCityLoc.statusCode == 200) {
      print(searchedCityLoc.body);
      final tempCityModel = jsonDecode(searchedCityLoc.body);
      final cityModel = SearchedCityModel.fromJson(tempCityModel);

      final lat = cityModel.lat;
      final lon = cityModel.lon;
      print('lat $lat lon:$lon');

      String endpoint2 =
          'weather?lat=$lat&lon=$lon&appid=${dotenv.env['API_Key']}';

      final url2 = Uri.parse('${dotenv.env['Base_URL']}$endpoint2');

      final response = await http.get(url2);
      if (response.statusCode == 200) {
        final tData = jsonDecode(response.body);
        final data = SearchedWeatherModel.fromJSON(tData);
        debugPrint('${data.main.temp}');
        state = state.copyWith(currentWeather: data, loadingState: false);
      } else {
        debugPrint(
          'Failed to fetch  weather data for city: $city with status code ${response.statusCode}',
        );
        state = state.copyWith(
          err:
              'Failed to load weather data for city: $city with status code ${response.statusCode}',
          loadingState: false,
        );
      }
    } else {
      debugPrint(
        'failed to load location with status code:${searchedCityLoc.statusCode}',
      );
      state = state.copyWith(
        err: "Failed to load location data for city: $city",
        loadingState: false,
      );
    }
  }
}

final searchedWeatherViewModelProvider =
    NotifierProvider<SearchedWeatherViewModel, SearchedWeatherState>(() {
      return SearchedWeatherViewModel();
    });
