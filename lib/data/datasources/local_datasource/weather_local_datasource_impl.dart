import 'package:second_brain/core/extension_function.dart';
import 'package:second_brain/core/weather_feature/weather_type_enum.dart';
import 'package:second_brain/data/datasources/local_datasource/local_database.dart';
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource.dart';
import 'package:second_brain/data/models/weather_info_local_model.dart';
import 'package:second_brain/data/models/weather_info_response_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  final AppLocalDatabase appLocalDatabase;

  /// Constructor
  WeatherLocalDataSourceImpl(
    this.appLocalDatabase,
  );

  /// Gett last data from the database
  @override
  Future<WeatherInfoEntity?> getLastWeatherInfo() async {
    final WeatherInfoLocalModel? weatherInfoLocalData =
        await appLocalDatabase.getLast<WeatherInfoLocalModel>();
    if (weatherInfoLocalData != null) {
      return weatherInfoLocalData.mapToEntity();
    }
    return null;
  }

  /// Gett all data from the database
  @override
  Future<List<WeatherInfoEntity?>?> getAllLocalWeathers() async {
    final List<WeatherInfoLocalModel>? allWeatherData =
        await appLocalDatabase.getAll<WeatherInfoLocalModel>();
    if ((allWeatherData?.length ?? 0) > 0) {
      return allWeatherData
          ?.map((WeatherInfoLocalModel element) => element.mapToEntity())
          .toList();
    }
    return null;
  }

  /// Isert data to the database
  @override
  void cacheWeatherInfo(WeatherInfoResponseModel? weatherInfoResponseModel) {
    final WeatherInfoLocalModel localModel = WeatherInfoLocalModel(
      timezone: weatherInfoResponseModel?.timezone,
      name: weatherInfoResponseModel?.cityName,
      date: weatherInfoResponseModel?.date?.fromTimestampToDate(),
      visibility: weatherInfoResponseModel?.visibility?.toKM(),
    );
    final WeatherThemeEntity? themeEntity = weatherInfoResponseModel
        ?.weatherDescription?[0].main
        ?.toWeatherType()
        ?.toWeatherTheme();
    localModel.sys.target = WeatherSunsetSunriseLocalModel(
      sunset: weatherInfoResponseModel?.weatherSysData?.sunset
          ?.fromTimestampToTime(),
      sunrise: weatherInfoResponseModel?.weatherSysData?.sunrise
          ?.fromTimestampToTime(),
      country: weatherInfoResponseModel?.weatherSysData?.country,
      type: weatherInfoResponseModel?.weatherSysData?.type,
    );
    localModel.weather.addAll(<WeatherDescriptionLocalModel>[
      WeatherDescriptionLocalModel(
        main: weatherInfoResponseModel?.weatherDescription?[0].main,
        description:
            weatherInfoResponseModel?.weatherDescription?[0].description,
        icon: weatherInfoResponseModel?.weatherDescription?[0].icon,
      ),
    ]);
    localModel.main.target = WeatherMainLocalModel(
      temp: weatherInfoResponseModel?.weatherMainData?.temp?.toCelsius(),
      feelsLike: weatherInfoResponseModel?.weatherMainData?.feelsLike,
      tempMin: weatherInfoResponseModel?.weatherMainData?.tempMin?.toCelsius(),
      tempMax: weatherInfoResponseModel?.weatherMainData?.tempMax?.toCelsius(),
      pressure: weatherInfoResponseModel?.weatherMainData?.press,
      humidity: weatherInfoResponseModel?.weatherMainData?.humid,
    );
    localModel.wind.target = WeatherWindLocalModel(
      deg: weatherInfoResponseModel?.weatherWindData?.deg,
      speed: weatherInfoResponseModel?.weatherWindData?.speed?.toWindSpeed(),
    );
    localModel.clouds.target = WeatherCloudsLocalModel(
      all: weatherInfoResponseModel?.weatherCloudsData?.all,
    );
    localModel.weatherTheme.target = WeatherThemeLocalModel(
      firstColorHex: themeEntity?.firstColor?.value,
      secondColorHex: themeEntity?.secondColor?.value,
    );
    appLocalDatabase.insert<WeatherInfoLocalModel>(localModel);
  }
}
