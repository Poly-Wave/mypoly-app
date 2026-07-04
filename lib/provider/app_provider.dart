import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/flavor.dart';
import 'package:mypoly/generate/bills/model/agenda_response.dart';
import 'package:mypoly/generate/bills/model/bill_detail_response.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/similar_member_response.dart';
import 'package:mypoly/generate/users/model/terms_response.dart';
import 'package:mypoly/model/env.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_provider.g.dart';

@riverpod
Flavor flavor(Ref ref) => throw UnimplementedError();

@riverpod
FlutterSecureStorage secureStorage(Ref ref) => throw UnimplementedError();

@riverpod
SharedPreferences localStorage(Ref ref) => throw UnimplementedError();

@riverpod
PackageInfo packageInfo(Ref ref) => throw UnimplementedError();

@riverpod
Env env(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
class AppTerms extends _$AppTerms {
  @override
  List<TermsResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(termsServiceProvider).getTerms();
}

@Riverpod(keepAlive: true)
class AppCategories extends _$AppCategories {
  @override
  List<CategoryResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(categoryServiceProvider).getCategories();
}

class AgendaCountData {
  final int? viewCount;
  final int? voteCount;

  const AgendaCountData({this.viewCount, this.voteCount});

  AgendaCountData merge({int? viewCount, int? voteCount}) => AgendaCountData(
    viewCount: viewCount ?? this.viewCount,
    voteCount: voteCount ?? this.voteCount,
  );
}

@Riverpod(keepAlive: true)
class AgendaCount extends _$AgendaCount {
  @override
  Map<int, AgendaCountData> build() => {};

  AgendaCountData? get(int billId) => state[billId];

  void save({required int billId, int? viewCount, int? voteCount}) {
    final current = state[billId];

    state = {
      ...state,
      billId: current == null
          ? AgendaCountData(viewCount: viewCount, voteCount: voteCount)
          : current.merge(viewCount: viewCount, voteCount: voteCount),
    };
  }

  void saveAgendaResponse(AgendaResponse item) =>
      save(billId: item.billId, voteCount: item.totalVoteCount);

  void saveBillDetail(BillDetailResponse item) => save(
    billId: item.billId,
    viewCount: item.viewCount,
    voteCount: item.voteSummary.totalVoteCount,
  );

  AgendaResponse applyToAgendaResponse(AgendaResponse item) {
    final count = state[item.billId];
    if (count?.voteCount == null) return item;

    return item.copyWith(totalVoteCount: count!.voteCount!);
  }

  BillDetailResponse applyToBillDetail(BillDetailResponse item) {
    final count = state[item.billId];
    if (count == null) return item;

    return item.copyWith(
      viewCount: count.viewCount ?? item.viewCount,
      voteSummary: item.voteSummary.copyWith(
        totalVoteCount: count.voteCount ?? item.voteSummary.totalVoteCount,
      ),
    );
  }
}

@Riverpod(keepAlive: true)
class AgendaBookmark extends _$AgendaBookmark {
  @override
  Map<int, bool> build() => {};

  bool? get(int billId) => state[billId];

  void save({required int billId, required bool bookmarked}) {
    if (state[billId] == bookmarked) return;

    state = {...state, billId: bookmarked};
  }
}

@Riverpod(keepAlive: true)
class AppSimilarMembers extends _$AppSimilarMembers {
  @override
  List<SimilarMemberResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(memberServiceProvider).getSimilarMembers();

  void reset() => state = [];
}
