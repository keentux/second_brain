import 'package:json_annotation/json_annotation.dart';
import 'package:second_brain/core/data_mapper.dart';
import 'package:second_brain/core/extension_function.dart';
import 'package:second_brain/core/weather_feature/weather_type_enum.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

part 'weather_info_response_model.g.dart';

/// Class for WeatherCoordinate Response Model
@JsonSerializable()
class WeatherCoordinateResponseModel
    extends DataMapper<WeatherCoordinateEntity> {
  final double? lon;
  final double? lat;

  /// Constructor
  WeatherCoordinateResponseModel({
    this.lon,
    this.lat,
  });

  // Factory - Create from JSON
  factory WeatherCoordinateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCoordinateResponseModelFromJson(json);

  /// Convert from map to Entity
  @override
  WeatherCoordinateEntity mapToEntity() {
    return WeatherCoordinateEntity(
      lat: lat ?? 0.0,
      lon: lon ?? 0.0,
    );
  }
}

/// Class for WeatherDescription Response Model
@JsonSerializable()
class WeatherDescriptionResponseModel
    extends DataMapper<WeatherDescriptionEntity> {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  /// Constructor
  WeatherDescriptionResponseModel({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  /// Factory - Create from JSON
  factory WeatherDescriptionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherDescriptionResponseModelFromJson(json);

  /// Convert from map to entity
  @override
  WeatherDescriptionEntity mapToEntity() {
    return WeatherDescriptionEntity(
      id: id ?? 0,
      description: description ?? '',
      icon: icon ?? '',
      main: main ?? '',
    );
  }
}

/// Class for WeatherMain Response Model
@JsonSerializable()
class WeatherMainResponseModel extends DataMapper<WeatherMainInfoEntity> {
  @JsonKey(name: 'temp')
  final double? temp;
  @JsonKey(name: 'feels_like')
  final double? feelsLike;
  @JsonKey(name: 'temp_max')
  final double? tempMax;
  @JsonKey(name: 'temp_min')
  final double? tempMin;
  @JsonKey(name: 'pressure')
  final int? press;
  @JsonKey(name: 'humidity')
  final int? humid;

  /// Constructor
  WeatherMainResponseModel({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.press,
    this.humid,
  });

  /// Factory - Create from JSON
  factory WeatherMainResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherMainResponseModelFromJson(json);

  /// Create the Entity
  @override
  WeatherMainInfoEntity mapToEntity() {
    return WeatherMainInfoEntity(
      temp: temp?.toCelsius() ?? '',
      feelsLike: feelsLike ?? 0.0,
      tempMin: tempMin.toCelsius() ?? '',
      tempMax: tempMax.toCelsius() ?? '',
      pressure: press ?? 0,
      humidity: humid ?? 0,
    );
  }
}

/// Class for WeatherWind Response Model
@JsonSerializable()
class WeatherWindResponseModel extends DataMapper<WeatherWindInfoEntity> {
  final double? speed;
  final int? deg;

  /// Constructor
  WeatherWindResponseModel({
    this.speed,
    this.deg,
  });

  // Factory - Create from JSON
  factory WeatherWindResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherWindResponseModelFromJson(json);

  /// Convert from map to Entity
  @override
  WeatherWindInfoEntity mapToEntity() {
    return WeatherWindInfoEntity(
      speed: speed.toWindSpeed() ?? '',
      deg: deg ?? 0,
    );
  }
}

/// Class for WeatherCloud Response Model
@JsonSerializable()
class WeatherCloudResponseModel extends DataMapper<WeatherCloudsInfoEntity> {
  final int? all;

  /// Constructor
  WeatherCloudResponseModel({
    this.all,
  });

  // Factory - Create from JSON
  factory WeatherCloudResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherCloudResponseModelFromJson(json);

  /// Convert from map to Entity
  @override
  WeatherCloudsInfoEntity mapToEntity() {
    return WeatherCloudsInfoEntity(
      all: all ?? 0,
    );
  }
}

/// Class for WeatherSunsetSunrise Response Model
@JsonSerializable()
class WeatherSunsetSunriseResponseModel
    extends DataMapper<WeatherSunsetSunriseEntity> {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  /// Constructor
  WeatherSunsetSunriseResponseModel({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  // Factory - Create from JSON
  factory WeatherSunsetSunriseResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$WeatherSunsetSunriseResponseModelFromJson(json);

  /// Convert from map to Entity
  @override
  WeatherSunsetSunriseEntity mapToEntity() {
    return WeatherSunsetSunriseEntity(
      sunrise: sunrise?.fromTimestampToTime(),
      type: type ?? 0,
      id: id ?? 0,
      country: country ?? '',
      sunset: sunset?.fromTimestampToTime(),
    );
  }
}

/// Class for WeatherInfo Response Model
@JsonSerializable()
class WeatherInfoResponseModel extends DataMapper<WeatherInfoEntity> {
  @JsonKey(name: 'coord')
  WeatherCoordinateResponseModel? coordData;
  @JsonKey(name: 'weather')
  List<WeatherDescriptionResponseModel>? weatherDescription;
  @JsonKey(name: 'main')
  WeatherMainResponseModel? weatherMainData;
  @JsonKey(name: 'visibility')
  int? visibility;
  @JsonKey(name: 'wind')
  WeatherWindResponseModel? weatherWindData;
  @JsonKey(name: 'clouds')
  WeatherCloudResponseModel? weatherCloudsData;
  @JsonKey(name: 'dt')
  int? date;
  @JsonKey(name: 'sys')
  WeatherSunsetSunriseResponseModel? weatherSysData;
  @JsonKey(name: 'timezonz')
  int? timezone;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? cityName;

  /// Constructor
  WeatherInfoResponseModel({
    this.coordData,
    this.weatherDescription,
    this.weatherMainData,
    this.visibility,
    this.weatherWindData,
    this.weatherCloudsData,
    this.date,
    this.weatherSysData,
    this.timezone,
    this.id,
    this.cityName,
  });

  // Factory - Create from JSON
  factory WeatherInfoResponseModel.fromjson(Map<String, dynamic> json) =>
      _$WeatherInfoResponseModelFromJson(json);

  /// Create the Entity
  @override
  WeatherInfoEntity mapToEntity() {
    final List<WeatherDescriptionEntity>? weathersDescriptionEntity =
        weatherDescription
            ?.map((WeatherDescriptionResponseModel weatherDescriptionModel) =>
                weatherDescriptionModel.mapToEntity())
            .toList();
    final WeatherTypeEnum? weatherTypeEnum =
        weathersDescriptionEntity?[0].main?.toWeatherType();
    return WeatherInfoEntity(
      id: id ?? 0,
      weathers: weathersDescriptionEntity,
      main: weatherMainData?.mapToEntity() ?? const WeatherMainInfoEntity(),
      visibility: visibility?.toKM() ?? '',
      wind: weatherWindData?.mapToEntity() ?? const WeatherWindInfoEntity(),
      clouds:
          weatherCloudsData?.mapToEntity() ?? const WeatherCloudsInfoEntity(),
      dt: date?.fromTimestampToDate() ?? '',
      sys: weatherSysData?.mapToEntity() ?? const WeatherSunsetSunriseEntity(),
      name: cityName ?? '',
      timezone: timezone ?? 0,
      weatherTheme: weatherTypeEnum.toWeatherTheme(),
    );
  }
}
