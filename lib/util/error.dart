import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/model/error_response.dart';

String getErrorMessage(DioException e) {
  if (e.type == DioExceptionType.cancel) {
    debugPrint("$e");
    return "cancel";
  }
  final errorResponseData = e.response?.data;

  if (errorResponseData != null) {
    try {
      final response = ErrorResponse.fromJson(errorResponseData);
      debugPrint(response.code);
      return response.code;
    } catch (e) {
      debugPrint("$e");
      return "error";
    }
  } else {
    debugPrint("$e");
    return "error";
  }
}
