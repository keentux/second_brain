import 'dart:async';

import 'package:flutter/material.dart';
import 'package:second_brain/core/api_error_result_model.dart';
import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/api_result_state.dart';
import 'package:second_brain/core/base_components/base_params_usecase.dart';

class BaseViewModel extends ChangeNotifier {
  final StreamController<bool> _toggleLoading = StreamController.broadcast();

  StreamController<bool> get toggleLoading => _toggleLoading;

  void showLoadingIndicator(bool show) {
    _toggleLoading.add(show);
  }

  Future<ApiResultState<Type>?> executeParamsUseCase<Type, Params>(
      {required BaseParamsUseCase<Type, Params> useCase, Params? query}) async {
    showLoadingIndicator(true);
    final ApiResultModel<Type> apiResult = await useCase(query);
    return apiResult.when(
      success: (Type data) {
        showLoadingIndicator(false);
        return ApiResultState<Type>.data(data: data);
      },
      failure: (ApiErrorResultModel error) {
        showLoadingIndicator(false);
        return ApiResultState<Type>.error(
          errorResultModel: error,
        );
      },
    );
  }

  @override
  void dispose() {
    _toggleLoading.close();
    super.dispose();
  }
}
