import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/generate/bills/model/bookmarked_bill_response.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_response.dart';
import 'package:mypoly/generate/bills/model/my_voted_bill_response.dart';
import 'package:mypoly/generate/bills/model/search_agenda_response.dart';
import 'package:mypoly/provider/app_provider.dart';

part 'agenda.freezed.dart';
part 'agenda.g.dart';

@freezed
abstract class AgendaListData with _$AgendaListData {
  const factory AgendaListData({
    required int id,
    required String title,
    required CategoryResponse category,
    required int viewCount,
    required int voteCount,
    required DateTime registeredDate,
    String? headline,
  }) = _AgendaListData;

  factory AgendaListData.fromJson(Map<String, dynamic> json) =>
      _$AgendaListDataFromJson(json);
}

AgendaListData _applyAgendaCount(Ref ref, AgendaListData item) {
  final count = ref.read(agendaCountProvider.notifier).get(item.id);
  if (count == null) return item;

  return item.copyWith(
    viewCount: count.viewCount ?? item.viewCount,
    voteCount: count.voteCount ?? item.voteCount,
  );
}

extension AgendaListDataListExtension on List<AgendaListData> {
  List<AgendaListData> syncAgendaCount(Ref ref) {
    ref
        .read(agendaCountProvider.notifier)
        .saveAll(
          map(
            (item) => (
              billId: item.id,
              viewCount: item.viewCount,
              voteCount: item.voteCount,
            ),
          ),
        );

    return this;
  }
}

extension SearchAgendaResponseExtension on SearchAgendaResponse {
  AgendaListData toAgendaListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    final item = AgendaListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );

    return item;
  }
}

extension BookmarkedBillResponseExtension on BookmarkedBillResponse {
  AgendaListData toAgendaListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    final item = AgendaListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );

    return item;
  }
}

extension MyVotedBillResponseExtension on MyVotedBillResponse {
  AgendaListData toAgendaListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    final item = AgendaListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );

    return item;
  }
}

extension InterestAgendaResponseExtension on InterestAgendaResponse {
  AgendaListData toAgendaListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    final item = AgendaListData(
      id: billId,
      title: title,
      category: category,
      viewCount: 0,
      voteCount: 0,
      registeredDate: registeredDate,
    );

    return _applyAgendaCount(ref, item);
  }
}

extension MainAgendaResponseExtension on MainAgendaResponse {
  AgendaListData toAgendaListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    final item = AgendaListData(
      id: billId,
      title: (headline != null && headline!.isNotEmpty) ? headline! : title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );

    return item;
  }
}
