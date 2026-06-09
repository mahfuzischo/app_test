import 'package:appifylab_test/models/forecast_model.dart';

class ForecastState {
  final List<ForecastModel>? forecastModel;
  final String? error;
  final bool isLoading;

  ForecastState({this.forecastModel, this.error, this.isLoading = false});

  ForecastState copyWith({
    List<ForecastModel>? forecast,
    String? err,
    bool? loadingState,
  }) {
    return ForecastState(
      forecastModel: forecast ?? forecastModel,
      error: err ?? error,
      isLoading: loadingState ?? isLoading,
    );
  }
}
