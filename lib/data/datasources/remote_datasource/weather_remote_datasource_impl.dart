import 'package:http/http.dart';
import 'package:second_brain/core/api_call_helper.dart';
import 'package:second_brain/core/api_error_result_model.dart';
import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/app_constants.dart';
import 'package:second_brain/core/custom_connection_exception.dart';
import 'package:second_brain/core/extension_function.dart';
import 'package:second_brain/core/weather_feature/weather_req_model.dart';
import 'package:second_brain/data/datasources/remote_datasource/weather_remote_datasource.dart';
import 'package:second_brain/data/models/weather_info_response_model.dart';

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiCallHelper apiCallHelper;
  WeatherRemoteDataSourceImpl(this.apiCallHelper);

  @override
  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCity(
      {WeatherByCityReqModel? weatherByCityReqModel}) async {
    try {
      final ApiResultModel<Response> result = await apiCallHelper.getWS(
        uri: appGetOpenWeatherDetails,
        params: <String, dynamic>{
          appOpenWeatherCityNameKey: weatherByCityReqModel?.city,
          appOpenWeatherKey: weatherByCityReqModel?.keyID,
        },
      );
      return result.when(
        success: (Response response) {
          return ApiResultModel<WeatherInfoResponseModel?>.success(
            data: WeatherInfoResponseModel.fromjson(
              response.decodeJson(),
            ),
          );
        },
        failure: (ApiErrorResultModel errorModel) {
          return ApiResultModel<WeatherInfoResponseModel?>.failure(
              apiErrorResultEntity: errorModel);
        },
      );
    } on CustomConnectionException catch (exception) {
      throw CustomConnectionException(
        exceptionMessage: exception.exceptionMessage,
        exceptionCode: exception.exceptionCode,
      );
    }
  }

  @override
  Future<ApiResultModel<WeatherInfoResponseModel?>> getWeatherDataByCoord(
      {WeatherByCoordReqModel? weatherByCoordReqModel, String? keyID}) async {
    try {
      final ApiResultModel<Response> result = await apiCallHelper
          .getWS(uri: appGetOpenWeatherDetails, params: <String, dynamic>{
        appOpenWeatherLatKey: weatherByCoordReqModel?.lat,
        appOpenWeatherLonKey: weatherByCoordReqModel?.lon,
        appOpenWeatherKey: keyID,
      });
      return result.when(
        success: (Response response) {
          return ApiResultModel<WeatherInfoResponseModel?>.success(
            data: WeatherInfoResponseModel.fromjson(
              response.decodeJson(),
            ),
          );
        },
        failure: (ApiErrorResultModel errorModel) {
          return ApiResultModel<WeatherInfoResponseModel?>.failure(
              apiErrorResultEntity: errorModel);
        },
      );
    } on CustomConnectionException catch (exception) {
      throw CustomConnectionException(
        exceptionMessage: exception.exceptionMessage,
        exceptionCode: exception.exceptionCode,
      );
    }
  }
}
