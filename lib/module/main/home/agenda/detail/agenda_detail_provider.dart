import 'dart:async';

import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/enum/similar_topic_sort.dart';
import 'package:mypoly/generate/bills/model/bill_detail_response.dart';
import 'package:mypoly/generate/bills/model/bill_vote_summary_response.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/similar_topic_bill_response.dart';
import 'package:mypoly/module/main/home/bookmark/bookmark_provider.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'agenda_detail_provider.g.dart';

@riverpod
int agendaId(Ref ref) => throw UnimplementedError();

@Riverpod(keepAlive: true)
class AgendaDetailMutation extends _$AgendaDetailMutation {
  final _bookmarkDebounceTimers = <int, Timer>{};
  final _voteDebounceTimers = <int, Timer>{};
  final _bookmarkRequestVersions = <int, int>{};
  final _voteRequestVersions = <int, int>{};

  @override
  void build() {
    ref.onDispose(() {
      for (final timer in _bookmarkDebounceTimers.values) {
        timer.cancel();
      }
      for (final timer in _voteDebounceTimers.values) {
        timer.cancel();
      }
    });
  }

  void syncBookmark({
    required int billId,
    required bool bookmarked,
    required void Function(bool bookmarked) onSuccess,
    required void Function() onError,
  }) {
    _bookmarkDebounceTimers.remove(billId)?.cancel();

    final requestVersion = (_bookmarkRequestVersions[billId] ?? 0) + 1;
    _bookmarkRequestVersions[billId] = requestVersion;

    _bookmarkDebounceTimers[billId] = Timer(
      const Duration(milliseconds: 500),
      () async {
        try {
          final resultBookmarked = await ref
              .read(agendaServiceProvider)
              .updateBookmark(billId: billId, bookmarked: bookmarked);

          if (_bookmarkRequestVersions[billId] != requestVersion) return;

          unawaited(ref.read(bookmarksPagingProvider.notifier).onRefresh());
          onSuccess(resultBookmarked);
        } catch (_) {
          if (_bookmarkRequestVersions[billId] != requestVersion) return;

          onError();
        }
      },
    );
  }

  void syncVote({
    required int billId,
    required bool vote,
    required void Function() onError,
    void Function()? onSuccess,
  }) {
    _voteDebounceTimers.remove(billId)?.cancel();

    final requestVersion = (_voteRequestVersions[billId] ?? 0) + 1;
    _voteRequestVersions[billId] = requestVersion;

    _voteDebounceTimers[billId] = Timer(
      const Duration(milliseconds: 500),
      () async {
        try {
          await ref
              .read(voteServiceProvider)
              .voteOnBill(billId: billId, vote: vote);

          if (_voteRequestVersions[billId] != requestVersion) return;

          unawaited(ref.read(appSimilarMembersProvider.notifier).fetch());
          onSuccess?.call();
        } catch (_) {
          if (_voteRequestVersions[billId] != requestVersion) return;

          onError();
        }
      },
    );
  }
}

@riverpod
class AgendaDetail extends _$AgendaDetail {
  bool _disposed = false;
  bool? _syncedBookmark;

  @override
  BillDetailResponse? build() {
    _disposed = false;
    ref.onDispose(() => _disposed = true);

    ref.listen(agendaBookmarkProvider, (_, next) {
      final currentState = state;
      if (currentState == null) return;

      final shared = next[currentState.billId];
      if (shared == null || shared == currentState.bookmarked) return;

      _syncedBookmark = shared;
      state = currentState.copyWith(bookmarked: shared);
    });

    return null;
  }

  Future<void> fetch() async {
    final agendaId = ref.read(agendaIdProvider);
    final agendaCount = ref.read(agendaCountProvider.notifier);
    final agendaDetail = await ref
        .read(agendaServiceProvider)
        .getAgenda(agendaId);

    agendaCount.saveBillDetail(agendaDetail);
    final applied = agendaCount.applyToBillDetail(agendaDetail);

    final bookmark = ref.read(agendaBookmarkProvider.notifier);
    final shared = bookmark.get(applied.billId);
    if (shared != null) {
      state = applied.copyWith(bookmarked: shared);
    } else {
      state = applied;
      bookmark.save(billId: applied.billId, bookmarked: applied.bookmarked);
    }
    _syncedBookmark = state?.bookmarked;
  }

  void toggleBookmark({
    void Function()? onBookmarked,
    void Function()? onUnbookmarked,
  }) {
    final prevState = state;
    if (prevState == null) return;

    final nextBookmarked = !prevState.bookmarked;
    final nextState = prevState.copyWith(bookmarked: nextBookmarked);
    final bookmark = ref.read(agendaBookmarkProvider.notifier);

    state = nextState;
    bookmark.save(billId: nextState.billId, bookmarked: nextBookmarked);
    ref
        .read(agendaDetailMutationProvider.notifier)
        .syncBookmark(
          billId: nextState.billId,
          bookmarked: nextBookmarked,
          onSuccess: (resultBookmarked) {
            if (_disposed) return;

            bookmark.save(
              billId: nextState.billId,
              bookmarked: resultBookmarked,
            );

            final currentState = state;
            if (currentState == null ||
                currentState.billId != nextState.billId) {
              return;
            }

            _syncedBookmark = resultBookmarked;
            if (currentState.bookmarked != resultBookmarked) {
              state = currentState.copyWith(bookmarked: resultBookmarked);
            }

            if (resultBookmarked) {
              onBookmarked?.call();
            } else {
              onUnbookmarked?.call();
            }
          },
          onError: () {
            if (_disposed) return;

            final revertedBookmarked = _syncedBookmark ?? prevState.bookmarked;
            bookmark.save(
              billId: nextState.billId,
              bookmarked: revertedBookmarked,
            );

            final currentState = state;
            if (currentState == null ||
                currentState.billId != nextState.billId ||
                currentState.bookmarked != nextBookmarked) {
              return;
            }

            state = prevState.copyWith(bookmarked: revertedBookmarked);
          },
        );
  }

  void vote(bool vote) {
    final prevState = state;
    if (prevState == null) return;

    final prevVote = _voteResultToBool(prevState.voteSummary.myVoteResult);
    if (prevVote == vote) return;

    final nextVoteSummary = _updateVoteSummary(
      prevState.voteSummary,
      nextVote: vote,
    );
    final nextState = prevState.copyWith(voteSummary: nextVoteSummary);

    state = nextState;
    ref.read(agendaCountProvider.notifier).saveBillDetail(nextState);
    ref
        .read(agendaDetailMutationProvider.notifier)
        .syncVote(
          billId: nextState.billId,
          vote: vote,
          onError: () {
            if (_disposed) return;

            final currentState = state;
            if (currentState == null ||
                currentState.billId != nextState.billId ||
                _voteResultToBool(currentState.voteSummary.myVoteResult) !=
                    vote) {
              return;
            }

            state = prevState;
            ref.read(agendaCountProvider.notifier).saveBillDetail(prevState);
          },
        );
  }

  bool? _voteResultToBool(String? value) => switch (value) {
    "AGREE" => true,
    "DISAGREE" => false,
    _ => null,
  };

  String _voteToResult(bool vote) => vote ? "AGREE" : "DISAGREE";

  BillVoteSummaryResponse _updateVoteSummary(
    BillVoteSummaryResponse prevVoteSummary, {
    required bool nextVote,
  }) {
    final prevVote = _voteResultToBool(prevVoteSummary.myVoteResult);
    if (prevVote == nextVote) return prevVoteSummary;

    final voteChanged = prevVote != null && prevVote != nextVote;
    final agreeCount =
        (prevVoteSummary.agreeCount +
                (nextVote ? 1 : 0) -
                (voteChanged && prevVote ? 1 : 0))
            .clamp(0, 1 << 31);
    final disagreeCount =
        (prevVoteSummary.disagreeCount +
                (nextVote ? 0 : 1) -
                (voteChanged && !prevVote ? 1 : 0))
            .clamp(0, 1 << 31);
    final totalVoteCount =
        prevVoteSummary.totalVoteCount + (prevVote == null ? 1 : 0);

    return prevVoteSummary.copyWith(
      hasVoted: true,
      myVoteResult: _voteToResult(nextVote),
      agreeCount: agreeCount,
      disagreeCount: disagreeCount,
      totalVoteCount: totalVoteCount,
      agreeRatio: totalVoteCount == 0 ? 0 : agreeCount / totalVoteCount,
      disagreeRatio: totalVoteCount == 0 ? 0 : disagreeCount / totalVoteCount,
    );
  }
}

@riverpod
CategoryResponse agendaCategory(Ref ref, BillDetailResponse agendaDetail) => ref
    .read(appCategoriesProvider)
    .firstWhere(
      (category) => category.code == agendaDetail.category.categoryCode,
    );

@riverpod
class SimilarTopics extends _$SimilarTopics {
  @override
  List<(SimilarTopicSort, List<SimilarTopicBillResponse>)> build() => [];

  Future<void> fetch() async {
    final billId = ref.read(agendaIdProvider);
    final service = ref.read(agendaServiceProvider);

    final result = await Future.wait(
      SimilarTopicSort.values.map((sort) async {
        final bills = await service.getSimilarTopics(
          billId: billId,
          sortType: sort.value,
        );

        return (sort, bills);
      }),
    );

    if (!ref.mounted) return;

    state = result;
  }
}
