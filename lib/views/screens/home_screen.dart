import 'package:appifylab_test/view_models/current_weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  @override
  void initState() {
    Future.microtask(
      () => ref
          .read(currentWeatherViewModelProvider.notifier)
          .getCurrentWeather(),
    );
    super.initState();
  }

  int convertTemp(double kelvin) {
    double celsius = kelvin - 273.15;
    return celsius.round();
  }

  @override
  Widget build(BuildContext context) {
    final currentWeatherState = ref.watch(currentWeatherViewModelProvider);
    final currentWeather = currentWeatherState.weatherModel;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: currentWeatherState.isLoading
              ? Center(child: CircularProgressIndicator.adaptive())
              : currentWeather == null
              ? Center(child: Text('Weather data not available.'))
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: screenSize.height * .4,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(20, 87, 154, 1),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Text(
                                  '${currentWeather.city}, ${currentWeather.country}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: Colors.blue.shade300,
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        color: Colors.blue.shade300,
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.blue.shade300,
                            ),
                            child: currentWeather.weather == 'Clouds'
                                ? Icon(
                                    Icons.cloud,
                                    size: 50,
                                    color: Colors.white,
                                  )
                                : Icon(
                                    Icons.sunny,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '${convertTemp(currentWeather.main.temp!)}°',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${currentWeather.description}.Feels like ${convertTemp(currentWeather.main.feelsLike!)}°C',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${currentWeather.main.humidity}%',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Humidity',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${currentWeather.windSpeed}km/h',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'wind',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    Text(
                                      '${currentWeather.main.pressure}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'hPa',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: screenSize.height * .5,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 243, 238, 1),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
