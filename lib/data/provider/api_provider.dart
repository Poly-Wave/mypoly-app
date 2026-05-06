import 'package:mypoly/data/provider/dio_provider.dart';
import 'package:mypoly/generate/bills/api/bill_bookmark_api.dart';
import 'package:mypoly/generate/bills/api/category_api.dart';
import 'package:mypoly/generate/users/api/auth_api.dart';
import 'package:mypoly/generate/users/api/terms_api.dart';
import 'package:mypoly/generate/users/api/user_api.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_provider.g.dart';

@Riverpod(keepAlive: true)
CategoryApi categoryApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(envProvider).billsApiUrl;

  return CategoryApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
BillBookmarkApi billBookmarkApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(envProvider).billsApiUrl;

  return BillBookmarkApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(envProvider).usersApiUrl;

  return AuthApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
TermsApi termsApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(envProvider).usersApiUrl;

  return TermsApi(dio, baseUrl: apiUrl);
}

@Riverpod(keepAlive: true)
UserApi userApi(Ref ref) {
  final dio = ref.watch(dioProvider);
  final apiUrl = ref.watch(envProvider).usersApiUrl;

  return UserApi(dio, baseUrl: apiUrl);
}
