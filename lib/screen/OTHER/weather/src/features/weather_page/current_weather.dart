import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:satuncity/screen/OTHER/weather/src/entities/weather/weather_data.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/city_search_box.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/current_weather_controller.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/weather_icon_image.dart';
// import 'package:buddhist_datetime_dateformat/buddhist_datetime_dateformat.dart';
class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherDataValue = ref.watch(currentWeatherControllerProvider);
    final city = ref.watch(cityProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(city, style: Theme.of(context).textTheme.headline4),
        weatherDataValue.when(
          data: (weatherData) => CurrentWeatherContents(data: weatherData),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, __) => Text(e.toString()),
        ),
      ],
    );
  }
}

class CurrentWeatherContents extends ConsumerWidget {
  const CurrentWeatherContents({Key key, this.data}) : super(key: key);
  final WeatherData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    final temp = data.temp.celsius.toInt().toString();
    final minTemp = data.minTemp.celsius.toInt().toString();
    final maxTemp = data.maxTemp.celsius.toInt().toString();
    final highAndLow = 'H:$maxTemp° L:$minTemp°';
    // var dateTime = DateTime.now();
    //     var dateTimeWarning = DateFormat.yMMMMEEEEd(dateTime);
      //  var formatdate = dateTimeWarning.formatInBuddhistCalendarThai(dateTime);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        WeatherIconImage(iconUrl: data.iconUrl, size: 120),
        Text(
          '$temp ํ',
          style: TextStyle(
              color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold),
        ),
        Text(
          highAndLow,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Text('$dateTimeWarning')
      ],
    );
  }
}
