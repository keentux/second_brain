import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/weather_feature/weather_req_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

abstract class WeatherRepository {
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCoord({
    WeatherByCoordReqModel? weatherByCoordRequestModel,
  });

  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCity({
    WeatherByCityReqModel? weatherByCityReqModel,
  });

  Future<ApiResultModel<List<WeatherInfoEntity?>?>> getAllLocalWeathers();
}
