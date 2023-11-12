import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/weather_feature/weather_by_coord_req_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

abstract class WeatherRepository {
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCoord({
    WeatherByCoordReqModel? weatherByCoordRequestModel,
  });

  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCity({
    String? cityName,
  });

  Future<ApiResultModel<List<WeatherInfoEntity?>?>> getAllLocalWeathers();
}
