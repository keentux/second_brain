import 'dart:async';

import 'package:second_brain/core/api_result_state.dart';
import 'package:second_brain/core/base_components/base_view_model.dart';
import 'package:second_brain/core/weather_feature/weather_req_model.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';
import 'package:second_brain/domain/usecases/get_weather_data.dart';

class WeatherViewModel extends BaseViewModel {
  final GetWeatherDataByCoord getWeatherDataByCoord;
  final GetWeatherDataByCity getWeatherDataByCity;
  WeatherViewModel({
    required this.getWeatherDataByCoord,
    required this.getWeatherDataByCity,
  });

  String? _lastCity;
  String? get lastCity => _lastCity;

  /// Create a Stream containing ApiResultState<WeatherInfoEntity>
  final StreamController<ApiResultState<WeatherInfoEntity?>?> _weatherResult =
      StreamController<ApiResultState<WeatherInfoEntity?>?>.broadcast();

  /// Get the Stream created
  StreamController<ApiResultState<WeatherInfoEntity?>?> get weatherResult =>
      _weatherResult;

  /// Get the Weather By Coord
  Future<void> getWeatherByCoordinates(
      {WeatherByCoordReqModel? weatherByCoordReqModel}) async {
    final ApiResultState<WeatherInfoEntity?>? result =
        await executeParamsUseCase(
      useCase: getWeatherDataByCoord,
      query: weatherByCoordReqModel,
    );

    _weatherResult.add(result);
  }

  /// Get the Weather By cityname
  Future<void> getWeatherByCity(
      {WeatherByCityReqModel? weatherByCityReqModel}) async {
    // _lastCity = cityName;
    final ApiResultState<WeatherInfoEntity?>? result =
        await executeParamsUseCase(
      useCase: getWeatherDataByCity,
      query: weatherByCityReqModel,
    );

    _weatherResult.add(result);
  }

  @override
  void dispose() {
    _weatherResult.close();
    super.dispose();
  }
}
