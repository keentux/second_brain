import 'package:injectable/injectable.dart';
import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/weather_feature/weather_by_coord_req_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';
import 'package:second_brain/domain/repositories/weather_repository.dart';
import 'package:second_brain/core/base_components/base_params_usecase.dart';

@injectable
class GetWeatherDataByCoord
    implements BaseParamsUseCase<WeatherInfoEntity?, WeatherByCoordReqModel> {
  final WeatherRepository weatherRepository;

  GetWeatherDataByCoord(this.weatherRepository);

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> call(
      WeatherByCoordReqModel? weatherByCoordRequestModel) {
    return weatherRepository.getWeatherDataByCoord(
        weatherByCoordRequestModel: weatherByCoordRequestModel);
  }
}

@injectable
class GetWeatherDataByCity
    implements BaseParamsUseCase<WeatherInfoEntity?, String> {
  final WeatherRepository weatherRepository;

  GetWeatherDataByCity(this.weatherRepository);

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> call(String? cityName) {
    return weatherRepository.getWeatherDataByCity(cityName: cityName);
  }
}

@injectable
class GetAllLocalWeathers
    implements BaseParamsUseCase<List<WeatherInfoEntity?>?, NoParams> {
  final WeatherRepository weatherRepository;
  GetAllLocalWeathers(this.weatherRepository);

  @override
  Future<ApiResultModel<List<WeatherInfoEntity?>?>> call(NoParams? params) {
    return weatherRepository.getAllLocalWeathers();
  }
}
