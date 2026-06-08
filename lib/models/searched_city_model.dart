class SearchedCityModel {
  final String name;
  final double lat;
  final double lon;
  String country;

  SearchedCityModel({
    required this.name,
    required this.lat,
    required this.lon,
    required this.country,
  });

  factory SearchedCityModel.fromJson(Map<String, dynamic> json) {
    return SearchedCityModel(
      name: json['name'],
      lat: json['lat'],
      lon: json['lon'],
      country: json['country'],
    );
  }
}
