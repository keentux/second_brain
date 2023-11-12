import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class WeatherCloudsInfoEntity extends Equatable {
  final int? all;

  const WeatherCloudsInfoEntity({this.all});

  @override
  List<Object?> get props => <Object?>[all];
}

class WeatherCoordinateEntity extends Equatable {
  final double? lon;
  final double? lat;

  const WeatherCoordinateEntity({
    this.lon,
    this.lat,
  });

  @override
  List<Object?> get props => <Object?>[
        lon,
        lat,
      ];
}

class WeatherMainInfoEntity extends Equatable {
  final String? temp;
  final double? feelsLike;
  final String? tempMin;
  final String? tempMax;
  final int? pressure;
  final int? humidity;

  const WeatherMainInfoEntity({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  @override
  List<Object?> get props =>
      <Object?>[temp, feelsLike, tempMin, tempMax, pressure, humidity];
}

class WeatherSunsetSunriseEntity extends Equatable {
  final int? type;
  final int? id;
  final String? country;
  final String? sunrise;
  final String? sunset;

  const WeatherSunsetSunriseEntity({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @override
  List<Object?> get props => <Object?>[
        type,
        id,
        country,
        sunrise,
        sunset,
      ];
}

class WeatherDescriptionEntity extends Equatable {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  const WeatherDescriptionEntity({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  List<Object?> get props => <Object?>[
        id,
        main,
        description,
        icon,
      ];
}

class WeatherThemeEntity {
  final Color? firstColor;
  final Color? secondColor;

  const WeatherThemeEntity({
    this.firstColor,
    this.secondColor,
  });
}

class WeatherWindInfoEntity extends Equatable {
  final String? speed;
  final int? deg;

  const WeatherWindInfoEntity({
    this.speed,
    this.deg,
  });

  @override
  List<Object?> get props => <Object?>[
        speed,
        deg,
      ];
}

class WeatherInfoEntity extends Equatable {
  final WeatherCloudsInfoEntity? clouds;
  final String? dt;
  final int? id;
  final WeatherMainInfoEntity? main;
  final String? name;
  final WeatherSunsetSunriseEntity? sys;
  final int? timezone;
  final String? visibility;
  final List<WeatherDescriptionEntity?>? weathers;
  final WeatherThemeEntity? weatherTheme;
  final WeatherWindInfoEntity? wind;

  const WeatherInfoEntity({
    this.clouds,
    this.dt,
    this.id,
    this.main,
    this.name,
    this.sys,
    this.timezone,
    this.visibility,
    this.weathers,
    this.weatherTheme,
    this.wind,
  });

  @override
  List<Object?> get props => <Object?>[
        clouds,
        dt,
        id,
        main,
        name,
        sys,
        timezone,
        visibility,
        weathers,
        weatherTheme,
        wind,
      ];
}
