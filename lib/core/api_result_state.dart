import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:second_brain/core/api_error_result_model.dart';

part 'api_result_state.freezed.dart';

@freezed
class ApiResultState<T> with _$ApiResultState<T> {
  const factory ApiResultState.data({required T data}) = Data<T>;
  const factory ApiResultState.error(
      {required ApiErrorResultModel errorResultModel}) = Error<T>;
}
