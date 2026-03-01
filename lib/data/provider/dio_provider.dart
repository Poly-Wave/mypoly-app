import 'package:dio/dio.dart';
import 'package:mypoly/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dio_provider.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio();

  dio.interceptors.add(dioLogger);

  return dio;
}
