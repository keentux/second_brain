import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/weather_feature/weather_by_coord_req_model.dart';
import 'package:second_brain/data/models/weather_info_response_model.dart';

abstract class WeatherRemoteDataSource {
  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCoord(
      {WeatherByCoordReqModel? weatherByCoordReqModel});

  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCity(
      {String? cityName});
}
