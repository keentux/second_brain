import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_brain/core/api_result_state.dart';
import 'package:second_brain/domain/entities/weather_remote_entities.dart';

class WeatherCubit extends Cubit<ApiResultState<WeatherInfoEntity>?> {
  WeatherCubit() : super(null);

  Future<void> getWeatherByCity({String? cityName}) async {
    // emit(await executeParamUseCase());
  }
}
