import 'dart:convert';

import 'package:appifylab_test/models/searched_weather_model.dart';

import 'package:appifylab_test/states/searched_weather_state.dart';

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
    final url = Uri.parse('${dotenv.env['Base_URL']}$endpoint1');
    state = state.copyWith(loadingState: true, searched: true);

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final tData = jsonDecode(response.body);
      final data = SearchedWeatherModel.fromJSON(tData);

      state = state.copyWith(currentWeather: data, loadingState: false);
    } else {
      state = state.copyWith(
        err:
            'Failed to load weather data for city: $city with status code ${response.statusCode}',
        loadingState: false,
      );
    }
  }
}

final searchedWeatherViewModelProvider =
    NotifierProvider<SearchedWeatherViewModel, SearchedWeatherState>(() {
      return SearchedWeatherViewModel();
    });
