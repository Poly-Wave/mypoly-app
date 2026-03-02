import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/generate/users/api/auth_api.dart';
import 'package:mypoly/generate/users/model/token_refresh_request.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();

  final apiUrl = ref.watch(envProvider).usersApiUrl;

  dio.interceptors
    ..add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = ref.read(appAccessTokenProvider);

          if (accessToken != null) {
            options.headers["Authorization"] = "Bearer $accessToken";
          }

          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          final refreshToken = ref.read(appRefreshTokenProvider);

          if (refreshToken == null) {
            return handler.next(e);
          }

          if (e.response?.statusCode == 401) {
            debugPrint("토큰 재발급 시도");

            final dio = Dio()..interceptors.add(dioLogger);
            final authApi = AuthApi(dio, baseUrl: apiUrl);

            try {
              final response = await authApi.refresh(
                tokenRefreshRequest: TokenRefreshRequest(
                  refreshToken: refreshToken,
                ),
              );

              final newAccessToken = response.jwt;

              if (newAccessToken != null) {
                await ref
                    .read(appAccessTokenProvider.notifier)
                    .update(newAccessToken);
              }

              final options = e.requestOptions;

              options.headers.addAll({
                'Authorization': 'Bearer $newAccessToken',
              });

              final reResponse = await dio.fetch(options);

              return handler.resolve(reResponse);
            } on DioException catch (e) {
              // 네트워크 오류인지 확인
              if (e.type == DioExceptionType.connectionTimeout ||
                  e.type == DioExceptionType.receiveTimeout ||
                  e.type == DioExceptionType.sendTimeout ||
                  e.type == DioExceptionType.connectionError) {
                debugPrint("네트워크 오류 발생 - 토큰 유지");
                return handler.next(e);
              }

              if (e.response?.statusCode == 401) {
                debugPrint("401 - 토큰 삭제");
                await ref.read(appUserProvider.notifier).logout();
              }

              return handler.next(e);
            }
          }

          return handler.next(e);
        },
      ),
    )
    ..add(dioLogger);

  return dio;
}
