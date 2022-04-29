import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:satuncity/screen/OTHER/weather/src/entities/weather/weather_data.dart';
import 'package:satuncity/screen/OTHER/weather/src/features/weather_page/city_search_box.dart';
import 'package:satuncity/screen/OTHER/weather/src/repositories/api_error.dart';
import 'package:satuncity/screen/OTHER/weather/src/repositories/weather_repository.dart';

class CurrentWeatherController extends StateNotifier<AsyncValue<WeatherData>> {
  CurrentWeatherController(this._weatherRepository, {this.city})
      : super(const AsyncValue.loading()) {
    getWeather(city: city);
  }
  final HttpWeatherRepository _weatherRepository;
  final String city;

  Future<void> getWeather({String city}) async {
    try {
      state = const AsyncValue.loading();
      final weather = await _weatherRepository.getWeather(city: city);
      state = AsyncValue.data(WeatherData.from(weather));
    } on APIError catch (e) {
      state = e.asAsyncValue();
    }
  }
}

final currentWeatherControllerProvider = StateNotifierProvider.autoDispose<
    CurrentWeatherController, AsyncValue<WeatherData>>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final city = ref.watch(cityProvider);
  return CurrentWeatherController(weatherRepository, city: city);
});