import 'package:appifylab_test/models/current_weather_model.dart';

class CurrentWeatherState {
  final CurrentWeatherModel? weatherModel;
  final String? error;
  final bool isLoading;

  CurrentWeatherState({this.weatherModel, this.error, this.isLoading = false});

  CurrentWeatherState copyWith({
    CurrentWeatherModel? currentWeather,
    String? err,
    bool? loadingState,
  }) {
    return CurrentWeatherState(
      weatherModel: currentWeather ?? weatherModel,
      error: err ?? error,
      isLoading: loadingState ?? isLoading,
    );
  }
}
