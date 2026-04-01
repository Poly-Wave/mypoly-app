//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:mypoly/generate/users/model/session_validation_response.dart';

part 'internal_auth_session_controller_api.g.dart';

@RestApi()
abstract class InternalAuthSessionControllerApi {
  factory InternalAuthSessionControllerApi(Dio dio, {String? baseUrl}) =
      _InternalAuthSessionControllerApi;

  /// validate
  ///
  ///
  /// Parameters:
  /// * [userId]
  /// * [sid]
  /// * [authorization]
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  ///
  @GET('/internal/auth/session/validate')
  Future<SessionValidationResponse> validate({
    @Query('userId') required int userId,
    @Query('sid') required String sid,
    @Header('authorization') String? authorization,
    CancelToken? cancelToken,
  });
}
