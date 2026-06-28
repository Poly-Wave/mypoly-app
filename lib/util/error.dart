import 'package:dio/dio.dart';
import 'package:mypoly/model/error_response.dart';
import 'package:mypoly/util/logger.dart';

String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.cancel) {
    AppLogger.instance.talker.handle(e);
    return "cancel";
  }
  final errorResponseData = e.response?.data;

  if (errorResponseData != null) {
    try {
      final response = ErrorResponse.fromJson(errorResponseData);
      AppLogger.instance.talker.handle(response.code);
      return response.code;
    } catch (e) {
      AppLogger.instance.talker.handle(e);
      return "error";
    }
  } else {
    AppLogger.instance.talker.handle(e);
    return "error";
  }
}
