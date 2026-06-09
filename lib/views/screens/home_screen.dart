import 'package:appifylab_test/view_models/current_weather_view_model.dart';
import 'package:appifylab_test/view_models/forecast_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class Homescreen extends ConsumerStatefulWidget {
  const Homescreen({super.key});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(currentWeatherViewModelProvider.notifier).getCurrentWeather();
      ref.read(forecastViewModelProvider.notifier).getForecast();
    });
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
    final forecastState = ref.watch(forecastViewModelProvider);
    final forecast = forecastState.forecastModel;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child:
              currentWeatherState.isLoading ||
                  currentWeather == null && currentWeatherState.error == null
              ? Container(
                  width: double.infinity,
                  height: screenSize.height,
                  child: Center(child: CircularProgressIndicator.adaptive()),
                )
              : currentWeather == null && currentWeatherState.error != null
              ? Container(
                  width: double.infinity,
                  height: screenSize.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Unable to fetch weather'),

                      Text('${currentWeatherState.error}'),
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(currentWeatherViewModelProvider.notifier)
                              .getCurrentWeather();
                        },
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                )
              : currentWeather == null
              ? Container(
                  width: double.infinity,
                  height: screenSize.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Unable to fetch weather data'),

                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(currentWeatherViewModelProvider.notifier)
                              .getCurrentWeather();
                        },
                        child: Text('Refresh'),
                      ),
                    ],
                  ),
                )
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
                                        padding: EdgeInsets.all(10),
                                        color: Colors.blue.shade300,
                                        child: Icon(
                                          Icons.search,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      child: Container(
                                        // padding: EdgeInsets.all(5),
                                        color: Colors.blue.shade300,
                                        child: IconButton(
                                          iconSize: 28,
                                          onPressed: () async {
                                            await ref
                                                .read(
                                                  currentWeatherViewModelProvider
                                                      .notifier,
                                                )
                                                .getCurrentWeather();
                                          },
                                          icon: Icon(
                                            Icons.location_on_outlined,
                                            color: Colors.white,
                                          ),
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
                                : currentWeather.weather == 'Rains'
                                ? Icon(
                                    Icons.water,
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        height: screenSize.height * .2,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(245, 243, 238, 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: forecastState.isLoading
                            ? Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : forecast == null
                            ? Container(
                                width: double.infinity,
                                height: screenSize.height * .5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Unable to fetch forecast'),

                                    if (forecastState.error != null)
                                      Text('${forecastState.error}'),
                                    SizedBox(height: 20),

                                    ElevatedButton(
                                      onPressed: () {
                                        ref
                                            .read(
                                              forecastViewModelProvider
                                                  .notifier,
                                            )
                                            .getForecast();
                                      },
                                      child: Text('Refresh'),
                                    ),
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Text(
                                    "5 - Day Forecast",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: forecast.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        print('$index');
                                        final forecastData = forecast[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: 120,
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${DateFormat.EEEE().format(DateTime.parse(forecastData.dtTxt))} ',
                                                ),
                                                forecastData.weather == 'Clouds'
                                                    ? Icon(
                                                        Icons.cloud,
                                                        size: 24,
                                                        color: Colors.black,
                                                      )
                                                    : forecastData.weather ==
                                                          'Rains'
                                                    ? Icon(
                                                        Icons.water,
                                                        size: 24,
                                                        color: Colors.black,
                                                      )
                                                    : Icon(
                                                        Icons.sunny,
                                                        size: 24,
                                                        color: Colors.black,
                                                      ),
                                                Text(
                                                  '${convertTemp(forecastData.main.temp!)}°',
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
