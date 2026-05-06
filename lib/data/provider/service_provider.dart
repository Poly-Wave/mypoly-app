import 'package:mypoly/data/provider/api_provider.dart';
import 'package:mypoly/data/service/auth_service.dart';
import 'package:mypoly/data/service/bill_bookmark_service.dart';
import 'package:mypoly/data/service/category_service.dart';
import 'package:mypoly/data/service/terms_service.dart';
import 'package:mypoly/data/service/user_service.dart';
import 'package:mypoly/data/service/vote_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider.g.dart';

@Riverpod(keepAlive: true)
CategoryService categoryService(Ref ref) {
  final api = ref.watch(categoryApiProvider);

  return CategoryService(ref, api);
}

@Riverpod(keepAlive: true)
BillBookmarkService billBookmarkService(Ref ref) {
  final api = ref.watch(billBookmarkApiProvider);

  return BillBookmarkService(ref, api);
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final api = ref.watch(authApiProvider);

  return AuthService(ref, api);
}

@Riverpod(keepAlive: true)
TermsService termsService(Ref ref) {
  final api = ref.watch(termsApiProvider);

  return TermsService(ref, api);
}

@Riverpod(keepAlive: true)
UserService userService(Ref ref) {
  final api = ref.watch(userApiProvider);

  return UserService(ref, api);
}

@Riverpod(keepAlive: true)
VoteService voteService(Ref ref) {
  final api = ref.watch(voteApiProvider);

  return VoteService(ref, api);
}
