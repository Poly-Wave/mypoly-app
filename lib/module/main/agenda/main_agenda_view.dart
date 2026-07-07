import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/model/agenda.dart';
import 'package:mypoly/module/main/widget/agenda.dart';
import 'package:mypoly/module/main/widget/list.dart';
import 'package:mypoly/module/main/agenda/main_agenda_provider.dart';
import 'package:mypoly/module/main/agenda/widget/filter_header.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:collection/collection.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/data/provider/dio_provider.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/generate/bills/model/popular_agenda_response.dart';
import '../agenda/widget/collapsed_row.dart';
import '../agenda/widget/expanded_list.dart';
import 'dart:async';

@RoutePage()
class MainAgendaView extends HookConsumerWidget {
  const MainAgendaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(appUserNicknameProvider);
    final sort = ref.watch(sortProvider);
    final categories = ref.watch(categoriesProvider);
    final agendasProvider = ref.watch(agendasPagingProvider);

    return Container(
      color: ColorStyles.black,
      child: MPCustomScroll(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: .only(bottom: 20.h, left: 20.w, right: 20.w),
              child: _RealtimePopularAgendaSection(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: MainFilterHeaderDelegate(
              sort: sort,
              categories: categories,
              categoryText: () {
                final selectedCount = categories.length;
                return selectedCount > 0 ? '주제 $selectedCount' : '주제';
              }(),
              onSortChanged: ref.read(sortProvider.notifier).onChanged,
              onCategoryTap: () => ref
                  .read(categoriesProvider.notifier)
                  .showBottomSheet(context),
            ),
          ),
          PagedSliverList(
            state: agendasProvider,
            fetchNextPage: ref
                .read(agendasPagingProvider.notifier)
                .fetchNextPage,
            builderDelegate: PagedChildBuilderDelegate<AgendaListData>(
              itemBuilder: (context, item, index) => AgendaColumnItem(
                index: index,
                item: item,
                onTap: () => context.pushRoute(AgendaDetailRoute(id: item.id)),
              ),
              firstPageProgressIndicatorBuilder: (_) =>
                  Column(children: [MPHeight(180), MPLoading()]),
              firstPageErrorIndicatorBuilder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: .stretch,
                children: [
                  MPHeight(160),
                  EmptyWidget(
                    message: "문제가 발생했어요",
                    subMessage: "잠시 후 다시 시도해 주세요",
                    buttonText: "보러가기",
                    onTap: ref.read(agendasPagingProvider.notifier).onRefresh,
                  ),
                ],
              ),
              newPageProgressIndicatorBuilder: (_) =>
                  Center(child: MPLoading(size: 18)),
              newPageErrorIndicatorBuilder: (_) => const SizedBox.shrink(),
              noItemsFoundIndicatorBuilder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: .stretch,
                children: [
                  MPHeight(120),
                  EmptyWidget(
                    image: WebpImage.emptySearch,
                    message: "관심 있는 주제를 선택해주세요",
                    subMessage: "$nickname님이\n관심 갖고 있는 주제 위주로 볼 수 있어요.",
                    buttonText: "관심 주제 선택",
                    onTap: () => ref
                        .read(categoriesProvider.notifier)
                        .showBottomSheet(context),
                  ),
                ],
              ),
              noMoreItemsIndicatorBuilder: (_) => MPSafeBox(bottom: true),
            ),
          ),
        ],
      ),
    );
  }
}

class _RealtimePopularAgendaSection extends HookConsumerWidget {
  const _RealtimePopularAgendaSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = useState(false);
    final currentRankIndex = useState(0);
    final popularAgendas = useState<List<PopularAgendaResponse>>([]);
    final originalIds = useState<List<int>>([]);
    final isDataChange = useState(false);

    // final sampleSetA = [
    //   PopularAgendaResponse(
    //     rank: 1,
    //     billId: 101,
    //     title: '국가 첨단 전략산업 경쟁력 강화 특별법안',
    //     categoryName: '산업통상',
    //     registeredDate: DateTime.now(),
    //     viewCount: 120,
    //     viewCountWeekly: 15,
    //     rankChangeSteps: 0,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.same,
    //     voteCount: 45,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 2,
    //     billId: 102,
    //     title: '소상공인 보호 및 지원에 관한 법률 개정안',
    //     categoryName: '소상공인',
    //     registeredDate: DateTime.now(),
    //     viewCount: 230,
    //     viewCountWeekly: 45,
    //     rankChangeSteps: 1,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.up,
    //     voteCount: 88,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 3,
    //     billId: 103,
    //     title: '기후위기 대응을 위한 탄소중립 기본법',
    //     categoryName: '환경노동',
    //     registeredDate: DateTime.now(),
    //     viewCount: 340,
    //     viewCountWeekly: 12,
    //     rankChangeSteps: -1,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.down,
    //     voteCount: 67,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 4,
    //     billId: 104,
    //     title: '인공지능 산업 육성 및 신뢰 기반 조성법',
    //     categoryName: '과학기술',
    //     registeredDate: DateTime.now(),
    //     viewCount: 95,
    //     viewCountWeekly: 8,
    //     rankChangeSteps: 0,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.same,
    //     voteCount: 23,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 5,
    //     billId: 105,
    //     title: '가상자산 이용자 보호 등에 관한 법률',
    //     categoryName: '정무위원회',
    //     registeredDate: DateTime.now(),
    //     viewCount: 512,
    //     viewCountWeekly: 98,
    //     rankChangeSteps: 3,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.up,
    //     voteCount: 142,
    //     hasVoted: false,
    //   ),
    // ];

    // final sampleSetB = [
    //   PopularAgendaResponse(
    //     rank: 1,
    //     billId: 201,
    //     title: '[변경] 우주항공청 설립 및 운영에 관한 특별법안',
    //     categoryName: '과학기술',
    //     registeredDate: DateTime.now(),
    //     viewCount: 180,
    //     viewCountWeekly: 35,
    //     rankChangeSteps: 1,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.up,
    //     voteCount: 92,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 2,
    //     billId: 202,
    //     title: '[변경] 전세사기 피해자 지원 및 주거안정 특별법안',
    //     categoryName: '국토교통',
    //     registeredDate: DateTime.now(),
    //     viewCount: 420,
    //     viewCountWeekly: 110,
    //     rankChangeSteps: -1,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.down,
    //     voteCount: 310,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 3,
    //     billId: 203,
    //     title: '[변경] 고등교육법 일부개정법률안 처리 조율',
    //     categoryName: '교육문화',
    //     registeredDate: DateTime.now(),
    //     viewCount: 115,
    //     viewCountWeekly: 22,
    //     rankChangeSteps: 0,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.same,
    //     voteCount: 54,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 4,
    //     billId: 204,
    //     title: '[변경] 국민건강보험법 개정안 보건복지위 통과',
    //     categoryName: '보건복지',
    //     registeredDate: DateTime.now(),
    //     viewCount: 280,
    //     viewCountWeekly: 64,
    //     rankChangeSteps: 2,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.up,
    //     voteCount: 119,
    //     hasVoted: false,
    //   ),
    //   PopularAgendaResponse(
    //     rank: 5,
    //     billId: 205,
    //     title: '[변경] 조세특례제한법 개정안 발의안 검토',
    //     categoryName: '기획재정',
    //     registeredDate: DateTime.now(),
    //     viewCount: 195,
    //     viewCountWeekly: 41,
    //     rankChangeSteps: -2,
    //     rankChangeType: PopularAgendaResponseRankChangeTypeEnum.down,
    //     voteCount: 73,
    //     hasVoted: false,
    //   ),
    // ];

    useEffect(() {
      Future(() async {
        try {
          final dio = ref.read(dioProvider);
          final api = AgendaApi(
            dio,
            baseUrl: ref.read(envProvider).billsApiUrl,
          );

          final List<PopularAgendaResponse> result = await api
              .getPopularAgendas();

          popularAgendas.value = result;
        } catch (e) {
          debugPrint('실시간 인기 안건 조회 실패: $e');
        }
      });
      return null;
    }, []);

    // useEffect(() {
    //   popularAgendas.value = sampleSetA;

    //   bool isSetA = true;
    //   final timer = Timer.periodic(const Duration(seconds: 30), (t) {
    //     if (isSetA) {
    //       popularAgendas.value = sampleSetB;
    //     } else {
    //       popularAgendas.value = sampleSetA;
    //     }
    //     isSetA = !isSetA;
    //   });

    //   return timer.cancel;
    // }, []);

    useEffect(() {
      if (popularAgendas.value.isEmpty) return null;

      final List<int> newIds = popularAgendas.value
          .map((e) => e.billId)
          .toList();
      final bool isDataChanged = !const DeepCollectionEquality().equals(
        originalIds.value,
        newIds,
      );
      if (originalIds.value.isEmpty) {
        originalIds.value = newIds;
        currentRankIndex.value = 0;
        isDataChange.value = false;
      } else if (isDataChanged) {
        originalIds.value = newIds;
        currentRankIndex.value = 0;
        isDataChange.value = true;
      } else {
        currentRankIndex.value = 0;
        isDataChange.value = false;
      }

      if (!isDataChange.value) {
        currentRankIndex.value = 0;
        return null;
      } else {
        final timer = Timer.periodic(const Duration(seconds: 4), (t) {
          if (currentRankIndex.value == popularAgendas.value.length - 1) {
            currentRankIndex.value = 0;
            isDataChange.value = false;
            t.cancel();
          } else {
            currentRankIndex.value =
                (currentRankIndex.value + 1) % popularAgendas.value.length;
          }
        });
        return timer.cancel;
      }
    }, [isExpanded.value, popularAgendas.value]);

    if (popularAgendas.value.isEmpty) {
      return const SizedBox.shrink();
    }

    final EdgeInsets dynamicPadding = isExpanded.value
        ? EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w)
        : EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w);

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 320.w,
          child: CustomPaint(
            painter: _GradientBorderPainter(
              strokeWidth: 1.r,
              gradient: const LinearGradient(
                colors: [Color(0xFF49EFD9), Color(0xFF26CBC8)],
              ),
              radius: 8.r,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF222324),
                borderRadius: BorderRadius.circular(8.r),
              ),
              padding: dynamicPadding,
              child: isExpanded.value
                  ? ExpandedList(
                      items: popularAgendas.value,
                      isDataChange: isDataChange.value,
                      onCollapsePressed: () => isExpanded.value = false,
                    )
                  : CollapsedRow(
                      item: popularAgendas.value[currentRankIndex.value],
                      isDataChange: isDataChange.value,
                      onExpandPressed: () => isExpanded.value = true,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final Gradient gradient;
  final double radius;

  _GradientBorderPainter({
    required this.strokeWidth,
    required this.gradient,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect);

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
