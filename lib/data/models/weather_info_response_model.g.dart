// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCoordinateResponseModel _$WeatherCoordinateResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherCoordinateResponseModel(
      lon: (json['lon'] as num?)?.toDouble(),
      lat: (json['lat'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$WeatherCoordinateResponseModelToJson(
        WeatherCoordinateResponseModel instance) =>
    <String, dynamic>{
      'lon': instance.lon,
      'lat': instance.lat,
    };

WeatherDescriptionResponseModel _$WeatherDescriptionResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherDescriptionResponseModel(
      id: json['id'] as int?,
      main: json['main'] as String?,
      description: json['description'] as String?,
      icon: json['icon'] as String?,
    );

Map<String, dynamic> _$WeatherDescriptionResponseModelToJson(
        WeatherDescriptionResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };

WeatherMainResponseModel _$WeatherMainResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherMainResponseModel(
      temp: (json['temp'] as num?)?.toDouble(),
      feelsLike: (json['feels_like'] as num?)?.toDouble(),
      tempMin: (json['temp_min'] as num?)?.toDouble(),
      tempMax: (json['temp_max'] as num?)?.toDouble(),
      press: json['pressure'] as int?,
      humid: json['humidity'] as int?,
    );

Map<String, dynamic> _$WeatherMainResponseModelToJson(
        WeatherMainResponseModel instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'feels_like': instance.feelsLike,
      'temp_max': instance.tempMax,
      'temp_min': instance.tempMin,
      'pressure': instance.press,
      'humidity': instance.humid,
    };

WeatherWindResponseModel _$WeatherWindResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherWindResponseModel(
      speed: (json['speed'] as num?)?.toDouble(),
      deg: json['deg'] as int?,
    );

Map<String, dynamic> _$WeatherWindResponseModelToJson(
        WeatherWindResponseModel instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
    };

WeatherCloudResponseModel _$WeatherCloudResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherCloudResponseModel(
      all: json['all'] as int?,
    );

Map<String, dynamic> _$WeatherCloudResponseModelToJson(
        WeatherCloudResponseModel instance) =>
    <String, dynamic>{
      'all': instance.all,
    };

WeatherSunsetSunriseResponseModel _$WeatherSunsetSunriseResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherSunsetSunriseResponseModel(
      type: json['type'] as int?,
      id: json['id'] as int?,
      country: json['country'] as String?,
      sunrise: json['sunrise'] as int?,
      sunset: json['sunset'] as int?,
    );

Map<String, dynamic> _$WeatherSunsetSunriseResponseModelToJson(
        WeatherSunsetSunriseResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'country': instance.country,
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };

WeatherInfoResponseModel _$WeatherInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    WeatherInfoResponseModel(
      coordData: json['coord'] == null
          ? null
          : WeatherCoordinateResponseModel.fromJson(
              json['coord'] as Map<String, dynamic>),
      weatherDescription: (json['weather'] as List<dynamic>?)
          ?.map((e) => WeatherDescriptionResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      weatherMainData: json['main'] == null
          ? null
          : WeatherMainResponseModel.fromJson(
              json['main'] as Map<String, dynamic>),
      visibility: json['visibility'] as int?,
      weatherWindData: json['wind'] == null
          ? null
          : WeatherWindResponseModel.fromJson(
              json['wind'] as Map<String, dynamic>),
      weatherCloudsData: json['clouds'] == null
          ? null
          : WeatherCloudResponseModel.fromJson(
              json['clouds'] as Map<String, dynamic>),
      date: json['dt'] as int?,
      weatherSysData: json['sys'] == null
          ? null
          : WeatherSunsetSunriseResponseModel.fromJson(
              json['sys'] as Map<String, dynamic>),
      timezone: json['timezonz'] as int?,
      id: json['id'] as int?,
      cityName: json['name'] as String?,
    );

Map<String, dynamic> _$WeatherInfoResponseModelToJson(
        WeatherInfoResponseModel instance) =>
    <String, dynamic>{
      'coord': instance.coordData,
      'weather': instance.weatherDescription,
      'main': instance.weatherMainData,
      'visibility': instance.visibility,
      'wind': instance.weatherWindData,
      'clouds': instance.weatherCloudsData,
      'dt': instance.date,
      'sys': instance.weatherSysData,
      'timezonz': instance.timezone,
      'id': instance.id,
      'name': instance.cityName,
    };
