import 'dart:async';

import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/generate/bills/model/bill_vote_detail_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agenda_vote_provider.g.dart';

@riverpod
int agendaId(Ref ref) => throw UnimplementedError();

@riverpod
class VoteDetail extends _$VoteDetail {
  @override
  BillVoteDetailResponse? build() => null;

  Future<void> fetch() async {
    final agendaId = ref.read(agendaIdProvider);
    final voteDetail = await ref.read(agendaServiceProvider).getVote(agendaId);

    state = voteDetail;
  }
}
