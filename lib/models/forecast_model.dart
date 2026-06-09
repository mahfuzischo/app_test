class ForecastModel {
  Main main;
  String weather;
  String dtTxt;

  ForecastModel({
    required this.main,
    required this.weather,
    required this.dtTxt,
  });

  factory ForecastModel.fromJSON(Map<String, dynamic> json) {
    return ForecastModel(
      main: Main.fromJson(json['main']),
      weather: json['weather'][0]['main'],
      dtTxt: json['dt_txt'],
    );
  }
}

class Main {
  double? temp;
  double? tempMin;
  double? tempMax;

  Main({required this.temp, required this.tempMin, required this.tempMax});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    tempMin = double.tryParse(json['temp_min'].toString());
    tempMax = double.tryParse(json['temp_max'].toString());
  }
}

class Weather {
  String main;

  Weather({required this.main});
}
