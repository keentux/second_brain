import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:second_brain/core/api_error_result_model.dart';

part 'api_result_model.freezed.dart';

// Run `dart run build_runner build` to generate file

/// Model can return ApiResultModel.success and ApiResultModel.failure
///  success return the data typed
///  failure rturn the error typed
@freezed
class ApiResultModel<T> with _$ApiResultModel<T> {
  const factory ApiResultModel.success({
    required T data,
  }) = Success<T>;

  const factory ApiResultModel.failure(
      {required ApiErrorResultModel apiErrorResultEntity}) = Failure<T>;
}
