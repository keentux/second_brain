import 'package:second_brain/data/models/weather_info_response_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

abstract class WeatherLocalDataSource {
  Future<WeatherInfoEntity?> getLastWeatherInfo();

  Future<List<WeatherInfoEntity?>?> getAllLocalWeathers();

  void cacheWeatherInfo(WeatherInfoResponseModel? weatherInfoResponseModel);
}
