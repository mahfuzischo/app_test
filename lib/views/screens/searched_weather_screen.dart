import 'package:appifylab_test/view_models/searched_weather_view_model.dart';
import 'package:appifylab_test/views/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchedWeatherScreen extends ConsumerStatefulWidget {
  const SearchedWeatherScreen({super.key});

  @override
  ConsumerState<SearchedWeatherScreen> createState() =>
      _SearchedWeatherScreenState();
}

class _SearchedWeatherScreenState extends ConsumerState<SearchedWeatherScreen> {
  @override
  Widget build(BuildContext context) {
    final searchedtWeatherState = ref.watch(searchedWeatherViewModelProvider);
    final searchedWeather = searchedtWeatherState.weatherModel;
    final screenSize = MediaQuery.of(context).size;
    int convertTemp(double kelvin) {
      double celsius = kelvin - 273.15;
      return celsius.round();
    }

    return Scaffold(
      body: SafeArea(
        child: searchedtWeatherState.isLoading
            ? Center(child: CircularProgressIndicator())
            : searchedWeather == null &&
                  searchedtWeatherState.hasSearched == true
            ? Container(
                width: double.infinity,
                height: screenSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Unable to fetch weather'),
                    if (searchedtWeatherState.error!.isNotEmpty)
                      Text('${searchedtWeatherState.error}'),
                    SizedBox(height: 20),
                    Text('Search to find weather updates.'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SearchScreen();
                            },
                          ),
                        );
                      },
                      child: Text('Search'),
                    ),
                  ],
                ),
              )
            : searchedWeather == null
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                height: screenSize.height,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'Search to find weather updates.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SearchScreen();
                              },
                            ),
                          );
                        },
                        child: Text('Search'),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
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
                                '${searchedWeather.city}, ${searchedWeather.country}',
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
                          child: searchedWeather.weather == 'Clouds'
                              ? Icon(Icons.cloud, size: 50, color: Colors.white)
                              : Icon(
                                  Icons.sunny,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${convertTemp(searchedWeather.main.temp!)}°',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${searchedWeather.description}.Feels like ${convertTemp(searchedWeather.main.feelsLike!)}°C',
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
                                    '${searchedWeather.main.humidity}%',
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
                                    '${searchedWeather.windSpeed}km/h',
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
                                    '${searchedWeather.main.pressure}',
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

                  searchedtWeatherState.hasSearched == true &&
                          searchedtWeatherState.weatherModel != null
                      ? Container(
                          width: double.infinity,
                          height: screenSize.height * .3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Search to find weather updates.'),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SearchScreen();
                                      },
                                    ),
                                  );
                                },
                                child: Text('Search'),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
      ),
    );
  }
}
