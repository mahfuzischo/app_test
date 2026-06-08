class CurrentWeatherModel {
  final String weather;
  final String description;

  final double windSpeed;

  final Main main;
  final String city;
  final String country;

  CurrentWeatherModel({
    required this.weather,
    required this.description,

    required this.windSpeed,

    required this.main,
    required this.city,
    required this.country,
  });

  factory CurrentWeatherModel.fromJSON(Map<String, dynamic> json) {
    return CurrentWeatherModel(
      weather: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      main: Main.fromJson(json['main']),
      windSpeed: json['wind']['speed'],
      country: json['sys']['country'],
      city: json['name'],
    );
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }
}
