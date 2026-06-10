import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/model/agenda_response.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'main_home_provider.g.dart';

@Riverpod(keepAlive: true)
class AppAgendaTabs extends _$AppAgendaTabs {
  @override
  List<AgendaTabResponse> build() => [];

  Future<void> fetch() async =>
      state = await ref.read(agendaServiceProvider).getTabs();
}

@Riverpod(keepAlive: true)
class AppTabAgendas extends _$AppTabAgendas {
  @override
  List<(AgendaTabResponse, List<AgendaResponse>)> build() => [];

  Future<void> fetch() async => state = await Future.wait(
    ref
        .read(appAgendaTabsProvider)
        .map((tab) async => (tab, await _fetch(tab))),
  );

  Future<List<AgendaResponse>> _fetch(AgendaTabResponse tab) async {
    final response = await ref
        .read(agendaServiceProvider)
        .getAgendasByTab(tabCode: tab.code, size: 3);

    return response.content;
  }

  void reset() => state = [];
}

@Riverpod(keepAlive: true)
class AppInterestAgendas extends _$AppInterestAgendas {
  @override
  (List<AgendaListData>, List<AgendaListData>) build() => ([], []);

  Future<void> fetch() async =>
      state = await (_fetch(.popular), _fetch(.latest)).wait;

  Future<List<AgendaListData>> _fetch(MPSort sort) async {
    final response = await ref
        .read(agendaServiceProvider)
        .getInterestAgendas(sort: sort, size: 3);

    return response.content.map((item) => item.toAgendaListData(ref)).toList();
  }

  void reset() => state = ([], []);
}
