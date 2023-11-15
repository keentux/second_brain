import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:second_brain/core/api_error_result_model.dart';
import 'package:second_brain/core/api_result_model.dart';
import 'package:second_brain/core/app_constants.dart';
import 'package:second_brain/core/connectivity_helper.dart';
import 'package:second_brain/core/custom_connection_exception.dart';
import 'package:second_brain/core/extension_function.dart';

@injectable
class ApiCallHelper {
  final ConnectivityCheckerHelper connectivityCheckerHelper;
  ApiCallHelper(this.connectivityCheckerHelper);

  final String? baseUrl = appOpenWeatherBaseUrl;

  Map<String, String> _sharedDefaultHeader = <String, String>{};

  /// set the default configuration for each request header.
  Future<void> initSharedDefaultHeader(
      [String contentValue = appContentTypeValue]) async {
    _sharedDefaultHeader = <String, String>{};
    _sharedDefaultHeader.addAll(<String, String>{
      appContentTypeKey: contentValue,
    });
  }

  /// returns whether or not the user is connected
  Future<bool> _getConnectionState() async {
    final bool connResult = await connectivityCheckerHelper.checkConnectivity();
    return connResult;
  }

  /// represents the HTTP GET method
  ///  returns an HTTP response
  ///  @[params] should be added to the url as the api params
  Future<ApiResultModel<http.Response>> getWS({
    required String uri,
    Map<String, String> headers = const <String, String>{},
    Map<String, dynamic> params = const <String, dynamic>{},
  }) async {
    await initSharedDefaultHeader();
    _sharedDefaultHeader.addAll(headers);
    if (await _getConnectionState()) {
      try {
        final String finalUrl = '$baseUrl$uri';
        final http.Response response = await http
            .get(finalUrl.parseUri(params: params),
                headers: _sharedDefaultHeader)
            .timeout(appTimeOutDuration);
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return ApiResultModel<http.Response>.success(data: response);
        } else {
          return ApiResultModel<http.Response>.failure(
            apiErrorResultEntity: ApiErrorResultModel(
              message: response.reasonPhrase,
              statusCode: response.statusCode,
            ),
          );
        }
      } on TimeoutException catch (_) {
        return const ApiResultModel<http.Response>.failure(
          apiErrorResultEntity: ApiErrorResultModel(
            message: appCommonErrorUnexpectedMessage,
            statusCode: appTimeoutRequestStatusCode,
          ),
        );
      } on IOException catch (_) {
        throw CustomConnectionException(
          exceptionMessage: appCommonConnectionFailedMessage,
          exceptionCode: appIoExceptionStatusCode,
        );
      }
    } else {
      throw CustomConnectionException(
        exceptionMessage: appCommonConnectionFailedMessage,
        exceptionCode: appIoExceptionStatusCode,
      );
    }
  }
}
