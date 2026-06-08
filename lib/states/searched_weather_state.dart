import 'package:appifylab_test/models/current_weather_model.dart';
import 'package:appifylab_test/models/searched_weather_model.dart';

class SearchedWeatherState {
  final SearchedWeatherModel? weatherModel;
  final String? error;
  final bool isLoading;
  final bool hasSearched;

  SearchedWeatherState({
    this.weatherModel,
    this.error,
    this.isLoading = false,
    this.hasSearched = false,
  });

  SearchedWeatherState copyWith({
    SearchedWeatherModel? currentWeather,
    String? err,
    bool? loadingState,
    bool? searched,
  }) {
    return SearchedWeatherState(
      weatherModel: currentWeather ?? weatherModel,
      error: err ?? error,
      isLoading: loadingState ?? isLoading,
      hasSearched: searched ?? hasSearched,
    );
  }
}
