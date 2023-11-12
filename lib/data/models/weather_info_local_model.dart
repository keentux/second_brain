import 'dart:ui';

import 'package:objectbox/objectbox.dart';
import 'package:second_brain/core/data_mapper.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

@Entity()
class WeatherCloudsLocalModel extends DataMapper<WeatherCloudsInfoEntity> {
  int? id;
  int? all;

  WeatherCloudsLocalModel({
    this.id,
    this.all,
  });

  @override
  WeatherCloudsInfoEntity mapToEntity() {
    return WeatherCloudsInfoEntity(
      all: all,
    );
  }
}

@Entity()
class WeatherCoordLocalModel extends DataMapper<WeatherCoordinateEntity> {
  int? id;
  double? lon;
  double? lat;

  WeatherCoordLocalModel({this.id, this.lon, this.lat});

  @override
  WeatherCoordinateEntity mapToEntity() {
    return WeatherCoordinateEntity(
      lon: lon,
      lat: lat,
    );
  }
}

@Entity()
class WeatherMainLocalModel extends DataMapper<WeatherMainInfoEntity> {
  int? id;
  String? temp;
  double? feelsLike;
  String? tempMin;
  String? tempMax;
  int? pressure;
  int? humidity;

  WeatherMainLocalModel({
    this.id,
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  @override
  WeatherMainInfoEntity mapToEntity() {
    return WeatherMainInfoEntity(
      tempMin: tempMin,
      tempMax: tempMax,
      pressure: pressure,
      humidity: humidity,
      feelsLike: feelsLike,
      temp: temp,
    );
  }
}

@Entity()
class WeatherSunsetSunriseLocalModel
    extends DataMapper<WeatherSunsetSunriseEntity> {
  int? id;
  int? type;
  String? country;
  String? sunrise;
  String? sunset;

  WeatherSunsetSunriseLocalModel({
    this.id,
    this.type,
    this.country,
    this.sunrise,
    this.sunset,
  });

  @override
  WeatherSunsetSunriseEntity mapToEntity() {
    return WeatherSunsetSunriseEntity(
      id: id,
      sunset: sunset,
      country: country,
      type: type,
      sunrise: sunrise,
    );
  }
}

@Entity()
class WeatherDescriptionLocalModel
    extends DataMapper<WeatherDescriptionEntity> {
  int? id;
  String? main;
  String? description;
  String? icon;

  WeatherDescriptionLocalModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  @override
  WeatherDescriptionEntity mapToEntity() {
    return WeatherDescriptionEntity(
      id: id,
      main: main,
      icon: icon,
      description: description,
    );
  }
}

@Entity()
class WeatherThemeLocalModel extends DataMapper<WeatherThemeEntity> {
  int? id;
  int? firstColorHex;
  int? secondColorHex;

  WeatherThemeLocalModel({
    this.id,
    this.firstColorHex,
    this.secondColorHex,
  });

  @override
  WeatherThemeEntity mapToEntity() {
    return WeatherThemeEntity(
      secondColor: Color(secondColorHex ?? 0),
      firstColor: Color(firstColorHex ?? 0),
    );
  }
}

@Entity()
class WeatherWindLocalModel extends DataMapper<WeatherWindInfoEntity> {
  int? id;
  String? speed;
  int? deg;

  WeatherWindLocalModel({
    this.id,
    this.speed,
    this.deg,
  });

  @override
  WeatherWindInfoEntity mapToEntity() {
    return WeatherWindInfoEntity(
      deg: deg,
      speed: speed,
    );
  }
}

@Entity()
class WeatherInfoLocalModel extends DataMapper<WeatherInfoEntity> {
  final ToMany<WeatherDescriptionLocalModel> weather =
      ToMany<WeatherDescriptionLocalModel>();
  final ToOne<WeatherMainLocalModel> main = ToOne<WeatherMainLocalModel>();
  final ToOne<WeatherWindLocalModel> wind = ToOne<WeatherWindLocalModel>();
  final ToOne<WeatherCloudsLocalModel> clouds =
      ToOne<WeatherCloudsLocalModel>();
  final ToOne<WeatherSunsetSunriseLocalModel> sys =
      ToOne<WeatherSunsetSunriseLocalModel>();
  final ToOne<WeatherThemeLocalModel> weatherTheme =
      ToOne<WeatherThemeLocalModel>();
  int? id;
  String? visibility;
  String? date;
  int? timezone;
  @Unique(onConflict: ConflictStrategy.replace)
  String? name;

  WeatherInfoLocalModel({
    this.id,
    this.visibility,
    this.date,
    this.timezone,
    this.name,
  });

  @override
  WeatherInfoEntity mapToEntity() {
    return WeatherInfoEntity(
      id: id,
      weathers: weather
          .map((WeatherDescriptionLocalModel element) => element.mapToEntity())
          .toList(),
      main: main.target?.mapToEntity(),
      visibility: visibility,
      wind: wind.target?.mapToEntity(),
      clouds: clouds.target?.mapToEntity(),
      dt: date,
      sys: sys.target?.mapToEntity(),
      timezone: timezone,
      name: name,
      weatherTheme: weatherTheme.target?.mapToEntity(),
    );
  }
}
