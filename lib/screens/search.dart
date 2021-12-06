import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:weather/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final openWeather = WeatherFactory('a2db19caba495fd4db81fc39f35c01ec');
  Weather? weather;
  String cityOrCountryName = '';

  bool isLoading = false;

  Future<void> getWeather() async {
    setState(() => isLoading = !isLoading);
    try {
      weather = await openWeather.currentWeatherByCityName(cityOrCountryName);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: Text('Close'),
            )
          ],
        ),
      );
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(e.toString()),
      //     duration: Duration(seconds: 10),
      //   ),
      // );
    }
    setState(() => isLoading = !isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) => cityOrCountryName = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a country name or city name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      getWeather();
                    },
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: weather != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${weather!.temperature!.celsius!.round()}°C',
                            style: TextStyle(
                              fontSize: 45,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${weather!.weatherDescription}',
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
