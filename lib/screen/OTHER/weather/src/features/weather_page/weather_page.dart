import 'package:flutter/material.dart';
import 'package:satuncity/screen/OTHER/weather/src/constants/app_colors.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/current_weather.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/hourly_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key key, this.city}) : super(key: key);
  final String city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: AppColors.rainGradient,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children:  [
              Spacer(),
              // CitySearchBox(),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'จ.สตูล ',
                      style: TextStyle(fontSize: 36),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              // Spacer(),
              CurrentWeather(),
              
              Spacer(),
              HourlyWeather(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
