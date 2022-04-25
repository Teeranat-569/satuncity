// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';
part 'weather.g.dart';

@freezed
class WeatherParams with _$WeatherParams {
  factory WeatherParams({
    double temp,
    @JsonKey(name: 'temp_min') double tempMin,
    @JsonKey(name: 'temp_max') double tempMax,
  }) = _WeatherParams;

  factory WeatherParams.fromJson(Map<String, dynamic> json) =>
      _$WeatherParamsFromJson(json);
}

@freezed
class WeatherInfo with _$WeatherInfo {
  factory WeatherInfo({
    String main,
    String description,
    String icon,
  }) = _WeatherInfo;

  factory WeatherInfo.fromJson(Map<String, dynamic> json) =>
      _$WeatherInfoFromJson(json);
}

/// Weather data parsed from the API response (not used directly in the UI)
@freezed
class Weather with _$Weather {
  factory Weather({
    @JsonKey(name: 'main') WeatherParams weatherParams,
    @JsonKey(name: 'weather') List<WeatherInfo> weatherInfo,
    int dt,
  }) = _Weather;

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}
