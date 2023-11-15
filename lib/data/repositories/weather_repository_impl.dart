import 'package:second_brain/core/api_error_result_model.dart';
import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/custom_connection_exception.dart';
import 'package:second_brain/core/weather_feature/weather_req_model.dart';
import 'package:second_brain/data/datasources/local_datasource/weather_local_datasource.dart';
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource.dart';
import 'package:second_brain/data/models/weather_info_response_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';
import 'package:second_brain/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;
  final WeatherLocalDataSource localDataSource;

  WeatherRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCoord({
    WeatherByCoordReqModel? weatherByCoordRequestModel,
  }) async {
    try {
      final ApiResultModel<WeatherInfoResponseModel?> result =
          await remoteDataSource.getWeatherDataByCoord(
              weatherByCoordReqModel: weatherByCoordRequestModel);
      return result.when(
        success: (WeatherInfoResponseModel? weatherInfoResponseModel) {
          if (weatherInfoResponseModel != null) {
            localDataSource.cacheWeatherInfo(weatherInfoResponseModel);
          }
          return ApiResultModel<WeatherInfoEntity?>.success(
            data: weatherInfoResponseModel?.mapToEntity(),
          );
        },
        failure: (ApiErrorResultModel apiErrorResultEntity) {
          return ApiResultModel<WeatherInfoEntity>.failure(
            apiErrorResultEntity: apiErrorResultEntity,
          );
        },
      );
    } on CustomConnectionException catch (_) {
      return ApiResultModel<WeatherInfoEntity?>.success(
        data: await localDataSource.getLastWeatherInfo(),
      );
    }
  }

  @override
  Future<ApiResultModel<WeatherInfoEntity?>> getWeatherDataByCity({
    WeatherByCityReqModel? weatherByCityReqModel,
  }) async {
    try {
      final ApiResultModel<WeatherInfoResponseModel?> result =
          await remoteDataSource.getWeatherDataByCity(
              weatherByCityReqModel: weatherByCityReqModel);
      return result.when(
        success: (WeatherInfoResponseModel? weatherInfoResponseModel) {
          if (weatherInfoResponseModel != null) {
            localDataSource.cacheWeatherInfo(weatherInfoResponseModel);
          }
          return ApiResultModel<WeatherInfoEntity?>.success(
            data: weatherInfoResponseModel?.mapToEntity(),
          );
        },
        failure: (ApiErrorResultModel apiErrorResultEntity) {
          return ApiResultModel<WeatherInfoEntity>.failure(
            apiErrorResultEntity: apiErrorResultEntity,
          );
        },
      );
    } on CustomConnectionException catch (_) {
      return ApiResultModel<WeatherInfoEntity?>.success(
        data: await localDataSource.getLastWeatherInfo(),
      );
    }
  }

  @override
  Future<ApiResultModel<List<WeatherInfoEntity?>?>>
      getAllLocalWeathers() async {
    return ApiResultModel<List<WeatherInfoEntity?>?>.success(
      data: await localDataSource.getAllLocalWeathers(),
    );
  }
}
