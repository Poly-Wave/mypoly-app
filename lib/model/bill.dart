import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/generate/bills/model/bookmarked_bill_response.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/interest_agenda_response.dart';
import 'package:mypoly/generate/bills/model/main_agenda_response.dart';
import 'package:mypoly/generate/bills/model/my_voted_bill_response.dart';
import 'package:mypoly/generate/bills/model/search_agenda_response.dart';
import 'package:mypoly/provider/app_provider.dart';

part 'bill.freezed.dart';
part 'bill.g.dart';

@freezed
abstract class BillListData with _$BillListData {
  const factory BillListData({
    required int id,
    required String title,
    required CategoryResponse category,
    required int viewCount,
    required int voteCount,
    required DateTime registeredDate,
  }) = _BillListData;

  factory BillListData.fromJson(Map<String, dynamic> json) =>
      _$BillListDataFromJson(json);
}

extension SearchAgendaResponseExtension on SearchAgendaResponse {
  BillListData toBillListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    return BillListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );
  }
}

extension BookmarkedBillResponseExtension on BookmarkedBillResponse {
  BillListData toBillListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    return BillListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );
  }
}

extension MyVotedBillResponseExtension on MyVotedBillResponse {
  BillListData toBillListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    return BillListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );
  }
}

extension InterestAgendaResponseExtension on InterestAgendaResponse {
  BillListData toBillListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    return BillListData(
      id: billId,
      title: title,
      category: category,
      viewCount: 0,
      voteCount: 0,
      registeredDate: registeredDate,
    );
  }
}

extension MainAgendaResponseExtension on MainAgendaResponse {
  BillListData toBillListData(Ref ref) {
    final category = ref
        .read(appCategoriesProvider)
        .firstWhere((category) => category.code == categoryCode);

    return BillListData(
      id: billId,
      title: title,
      category: category,
      viewCount: viewCount,
      voteCount: voteCount,
      registeredDate: registeredDate,
    );
  }
}
