import 'package:appifylab_test/view_models/searched_weather_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    TextEditingController searchTextController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: Row(
            children: [
              Container(
                width: screenSize.width * .65,

                child: TextField(
                  controller: searchTextController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                    hintText: 'Search city...',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        if (searchTextController.text.length > 2) {
                          await ref
                              .read(searchedWeatherViewModelProvider.notifier)
                              .getCitytWeather(searchTextController.text);
                          Navigator.pop(context);
                        } else {
                          const snackbar = SnackBar(
                            content: Text(
                              'Please enter a city name with atleast 3 characters',
                              style: TextStyle(fontSize: 18),
                            ),

                            elevation: 10,
                            behavior: SnackBarBehavior.floating,
                            margin: EdgeInsets.all(5),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
