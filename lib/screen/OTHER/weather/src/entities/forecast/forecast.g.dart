// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names

part of forecast;

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Forecast _$$_ForecastFromJson(Map<String, dynamic> json) => _$_Forecast(
      list: (json['list'] as List<dynamic>)
          .map((e) => Weather.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ForecastToJson(_$_Forecast instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
