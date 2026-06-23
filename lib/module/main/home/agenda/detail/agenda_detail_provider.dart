import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/generate/bills/model/bill_detail_response.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agenda_detail_provider.g.dart';

@riverpod
int agendaId(Ref ref) => throw UnimplementedError();

@riverpod
class AgendaDetail extends _$AgendaDetail {
  @override
  BillDetailResponse? build() => null;

  Future<void> fetch() async {
    final agendaId = ref.watch(agendaIdProvider);

    state = await ref.read(agendaServiceProvider).getAgenda(agendaId);
  }
}

@riverpod
CategoryResponse agendaCategory(Ref ref, BillDetailResponse agendaDetail) => ref
    .read(appCategoriesProvider)
    .firstWhere(
      (category) => category.code == agendaDetail.category.categoryCode,
    );
