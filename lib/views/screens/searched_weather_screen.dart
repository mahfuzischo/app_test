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
            ? Center(
                child: Column(
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
                        Row(),
                        Row(),
                        Row(),
                        Row(),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
