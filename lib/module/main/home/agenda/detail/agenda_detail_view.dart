import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/similar_topic_sort.dart';
import 'package:mypoly/generate/bills/model/similar_topic_bill_response.dart';
import 'package:mypoly/module/main/agenda/main_agenda_provider.dart';
import 'package:mypoly/module/main/home/agenda/detail/agenda_detail_provider.dart';
import 'package:mypoly/module/main/main_provider.dart';
import 'package:mypoly/module/main/widget/agenda.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:mypoly/widget/overlay/index.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class AgendaDetailProviderView extends StatelessWidget {
  final int id;

  const AgendaDetailProviderView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        agendaIdProvider.overrideWithValue(id),
        agendaDetailProvider.overrideWith(AgendaDetail.new),
        similarTopicsProvider.overrideWith(SimilarTopics.new),
      ],
      child: AgendaDetailView(),
    );
  }
}

class AgendaDetailView extends HookConsumerWidget {
  const AgendaDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final id = ref.watch(agendaIdProvider);
    final agendaDetail = ref.watch(agendaDetailProvider);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(agendaDetailProvider.notifier).fetch();
        ref.read(similarTopicsProvider.notifier).fetch();
        ref.read(appSimilarMembersProvider.notifier).fetch();
      });

      return null;
    }, []);

    final selectedSort = useState(SimilarTopicSort.hotDebate);
    final similarTopics = ref.watch(similarTopicsProvider);
    final similarMembers = ref.watch(appSimilarMembersProvider);

    if (agendaDetail == null || similarMembers == null) {
      return Scaffold(
        appBar: MPAppBar(context, text: "의안 상세"),
        body: MPSafeBox(bottom: true, child: Center(child: MPLoading())),
      );
    }

    final agendaCategory = ref.watch(agendaCategoryProvider(agendaDetail));

    final similarTopicMatches = similarTopics.where(
      (entry) => entry.$1 == selectedSort.value,
    );
    final similarTopicBills = similarTopicMatches.isEmpty
        ? const <SimilarTopicBillResponse>[]
        : similarTopicMatches.first.$2;

    return Scaffold(
      appBar: MPAppBar(
        context,
        text: "의안 상세",
        right: MPBookmark(
          checked: agendaDetail.bookmarked,
          onTap: () => ref
              .read(agendaDetailProvider.notifier)
              .toggleBookmark(
                onBookmarked: () =>
                    showMPSnackBar(context, message: "북마크 추가를 완료했습니다."),
                onUnbookmarked: () =>
                    showMPSnackBar(context, message: "북마크를 해제하였습니다."),
              ),
        ),
      ),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: Padding(
                padding: .symmetric(vertical: 20.h, horizontal: 20.w),
                child: MPSafeColumn(
                  bottom: true,
                  crossAxisAlignment: .stretch,
                  children: [
                    Row(
                      spacing: 4.w,
                      children: [
                        AgendaCategoryBadge(category: agendaCategory),
                        Text(
                          agendaDetail.proposalDate.toDotYMD,
                          style: Pretendard.medium.set(
                            size: 14,
                            color: ColorStyles.gray30,
                          ),
                        ),
                      ],
                    ),
                    MPHeight(10),
                    Text(
                      agendaDetail.officialTitle.wrapped,
                      style: Pretendard.semiBold.set(
                        size: 24,
                        height: 1.3,
                        letterSpacing: -0.54,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(10),
                    SizedBox(
                      height: 23.h,
                      child: Row(
                        children: [
                          Text(
                            "${agendaDetail.representativeProposerName} 의원 외 ${agendaDetail.proposerCount - 1}명",
                            style: Pretendard.semiBold.set(
                              size: 16,
                              color: ColorStyles.gray30,
                            ),
                          ),
                          MPSvgImage(SvgImage.arrowRight, size: 16),
                        ],
                      ),
                    ),
                    MPHeight(10),
                    Container(
                      height: 46.h,
                      padding: .symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: GradientBoxBorder(
                          gradient: LinearGradient(
                            colors: [Color(0xFF2E5C66), Color(0xFF769999)],
                          ),
                          width: 1.r,
                        ),
                        borderRadius: .circular(8.r),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFA5FFEF).withValues(alpha: 0.1),
                            Color(0xFF256D86).withValues(alpha: 0.1),
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => showMPBottomSheetModal(
                              context,
                              children: [
                                MPBottomSheetCloseHeader(),
                                Padding(
                                  padding: .symmetric(horizontal: 20.w),
                                  child: Column(
                                    crossAxisAlignment: .stretch,
                                    children: [
                                      Text(
                                        "심사 진행 단계란?",
                                        style: Pretendard.semiBold.set(
                                          size: 16,
                                          height: 1.45,
                                          color: ColorStyles.white,
                                        ),
                                      ),
                                      MPHeight(12),
                                      Text(
                                        "국회의원이 발의된 법안이 실제 국회에서 어떤 절차를 거치고 있는지 알려주는 단계예요. 단계는 접수, 심사, 의결, 완료 총 4단계로 나눠져있어요."
                                            .wrapped,
                                        style: Pretendard.medium.set(
                                          size: 15,
                                          height: 1.45,
                                          color: ColorStyles.gray20,
                                        ),
                                      ),
                                      MPHeight(30),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            child: Row(
                              spacing: 4.w,
                              children: [
                                Text(
                                  "심사 진행 단계",
                                  style: Pretendard.medium.set(
                                    size: 15,
                                    color: ColorStyles.primary10,
                                  ),
                                ),
                                MPSvgImage(
                                  SvgImage.icInfo,
                                  size: 16,
                                  color: ColorStyles.primary10,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              String desc = "";

                              switch (agendaDetail.stage.uiStepOrder) {
                                case 1:
                                  desc =
                                      "의안이 국회에 제출되어 공식적으로 등록된 상태예요. 의원 발의 또는 정부 제출을 통해 접수되며, 이후 소관 위원회가 배정돼요.";
                                  break;
                                case 2:
                                  desc =
                                      "소관 상임위원회에서 의안의 내용을 검토하고 있는 단계예요. 전문위원 검토, 대체토론, 소위원회 심사 등을 거쳐 수정·가결·폐기 여부를 결정해요.";
                                  break;
                                case 3:
                                  desc =
                                      "위원회 심사를 마친 의안이 국회 본회의에 상정되어 표결되는 단계예요. 재적의원 과반수 출석, 출석의원 과반수 찬성 시 가결돼요.";
                                  break;
                                case 4:
                                  desc =
                                      "의결이 완료된 의안이 정부로 이송되거나 최종 처리된 상태예요. 가결된 법률안은 정부 이송 후 공포 절차를 거쳐 시행돼요.";
                                  break;
                              }

                              showMPBottomSheetModal(
                                context,
                                children: [
                                  MPBottomSheetCloseHeader(),
                                  Padding(
                                    padding: .symmetric(horizontal: 20.w),
                                    child: Column(
                                      crossAxisAlignment: .stretch,
                                      children: [
                                        Text(
                                          "진행 단계",
                                          style: Pretendard.semiBold.set(
                                            size: 16,
                                            height: 1.45,
                                            color: ColorStyles.white,
                                          ),
                                        ),
                                        MPHeight(12),
                                        Container(
                                          height: 76.h,
                                          padding: .symmetric(horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            borderRadius: .circular(8.r),
                                            color: ColorStyles.gray70,
                                          ),
                                          child: Column(
                                            mainAxisAlignment: .center,
                                            crossAxisAlignment: .stretch,
                                            spacing: 8.h,
                                            children: [
                                              Text(
                                                "안건 진행 상황",
                                                style: Pretendard.medium.set(
                                                  size: 15,
                                                  height: 1.45,
                                                  color: ColorStyles.white,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    .spaceBetween,
                                                children: [
                                                  AgedaDeailtStepOrder(
                                                    uiStepOrder: 1,
                                                    uiStepName: "접수",
                                                    isActive:
                                                        1 ==
                                                        agendaDetail
                                                            .stage
                                                            .uiStepOrder,
                                                  ),
                                                  MPSvgImage(
                                                    SvgImage.arrowRight,
                                                    size: 16,
                                                    color: ColorStyles.gray20,
                                                  ),
                                                  AgedaDeailtStepOrder(
                                                    uiStepOrder: 2,
                                                    uiStepName: "심사",
                                                    isActive:
                                                        2 ==
                                                        agendaDetail
                                                            .stage
                                                            .uiStepOrder,
                                                  ),
                                                  MPSvgImage(
                                                    SvgImage.arrowRight,
                                                    size: 16,
                                                    color: ColorStyles.gray20,
                                                  ),
                                                  AgedaDeailtStepOrder(
                                                    uiStepOrder: 3,
                                                    uiStepName: "의결",
                                                    isActive:
                                                        3 ==
                                                        agendaDetail
                                                            .stage
                                                            .uiStepOrder,
                                                  ),
                                                  MPSvgImage(
                                                    SvgImage.arrowRight,
                                                    size: 16,
                                                    color: ColorStyles.gray20,
                                                  ),
                                                  AgedaDeailtStepOrder(
                                                    uiStepOrder: 4,
                                                    uiStepName: "완료",
                                                    isActive:
                                                        4 ==
                                                        agendaDetail
                                                            .stage
                                                            .uiStepOrder,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        MPHeight(12),
                                        Text(
                                          desc.wrapped,
                                          style: Pretendard.medium.set(
                                            size: 15,
                                            height: 1.45,
                                            color: ColorStyles.gray20,
                                          ),
                                        ),
                                        MPHeight(30),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Row(
                              spacing: 4.w,
                              children: [
                                AgedaDeailtStepOrder(
                                  uiStepOrder: agendaDetail.stage.uiStepOrder,
                                  uiStepName: agendaDetail.stage.uiStepName,
                                ),
                                MPSvgImage(
                                  SvgImage.arrowRight,
                                  size: 16,
                                  color: ColorStyles.gray20,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    MPHeight(20),
                    Text(
                      agendaDetail.aiSummary.summary.wrapped,
                      style: Pretendard.medium.set(
                        size: 16,
                        height: 1.45,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(10),
                    Row(
                      mainAxisAlignment: .end,
                      spacing: 4.w,
                      children: [
                        MPSvgImage(SvgImage.icWrite, size: 18),
                        Text(
                          "AI 요약 완료",
                          style: Pretendard.medium.set(
                            size: 14,
                            color: ColorStyles.gray30,
                          ),
                        ),
                      ],
                    ),
                    MPHeight(20),
                    SizedBox(
                      height: 20.h,
                      child: GestureDetector(
                        onTap: () => launchUrlString(agendaDetail.detailUrl),
                        child: Row(
                          children: [
                            Text(
                              "안건 원문보기",
                              style: Pretendard.medium.set(
                                size: 14,
                                color: ColorStyles.gray30,
                              ),
                            ),
                            MPSvgImage(
                              SvgImage.arrowRight,
                              size: 16,
                              color: ColorStyles.gray30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    MPHeight(40),
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Text(
                            "이 안건에 대해\n어떻게 생각하세요?",
                            style: Pretendard.semiBold.set(
                              size: 20,
                              height: 1.35,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                        MPSvgImage(SvgImage.icVote, size: 48),
                      ],
                    ),
                    MPHeight(20),
                    if (agendaDetail.voteSummary.hasVoted) ...[
                      GestureDetector(
                        onTap: () =>
                            ref.read(agendaDetailProvider.notifier).vote(true),
                        child: AgendaVoteProgress(
                          text: '응원해요',
                          percent: (agendaDetail.voteSummary.agreeRatio * 100)
                              .round(),
                          vote:
                              agendaDetail.voteSummary.myVoteResult == "AGREE",
                        ),
                      ),
                      MPHeight(10),
                      GestureDetector(
                        onTap: () =>
                            ref.read(agendaDetailProvider.notifier).vote(false),
                        child: AgendaVoteProgress(
                          text: '아쉬워요',
                          percent:
                              (agendaDetail.voteSummary.disagreeRatio * 100)
                                  .round(),
                          vote:
                              agendaDetail.voteSummary.myVoteResult ==
                              "DISAGREE",
                        ),
                      ),
                    ] else ...[
                      MPButton(
                        "응원해요",
                        style: .gray,
                        height: 51,
                        onTap: () =>
                            ref.read(agendaDetailProvider.notifier).vote(true),
                        textStyle: Pretendard.medium.set(
                          size: 16,
                          color: ColorStyles.white,
                        ),
                      ),
                      MPHeight(10),
                      MPButton(
                        "아쉬워요",
                        style: .gray,
                        height: 51,
                        onTap: () =>
                            ref.read(agendaDetailProvider.notifier).vote(false),
                        textStyle: Pretendard.medium.set(
                          size: 16,
                          color: ColorStyles.white,
                        ),
                      ),
                    ],
                    MPHeight(20),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (agendaDetail.voteSummary.hasVoted) {
                            context.pushRoute(AgendaVoteRoute(id: id));
                            return;
                          }

                          showMPSnackBar(
                            context,
                            message: "🗳️ 투표하고 결과를 확인해 보세요.",
                          );
                        },
                        child: Container(
                          height: 32.h,
                          padding: .symmetric(horizontal: 10.w),
                          child: Text(
                            agendaDetail.voteSummary.hasVoted
                                ? "자세히 보러가기"
                                : "투표하고 결과보기",
                            style: Pretendard.semiBold.set(
                              size: 14,
                              color: ColorStyles.gray20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    MPHeight(40),
                    Container(height: 1.h, color: ColorStyles.gray80),
                    MPHeight(40),
                    Text(
                      "나와 유사한 성향의 국회의원은?",
                      style: Pretendard.semiBold.set(
                        size: 20,
                        height: 1.35,
                        color: ColorStyles.gray10,
                      ),
                    ),
                    MPHeight(20),
                    if (similarMembers.isEmpty)
                      Container(
                        height: 300.h,
                        decoration: BoxDecoration(
                          borderRadius: .circular(12.r),
                          color: ColorStyles.divider,
                        ),
                        child: Column(
                          mainAxisAlignment: .center,
                          crossAxisAlignment: .stretch,
                          children: [
                            Center(
                              child: MPSvgImage(
                                SvgImage.emptyMembers,
                                size: 64,
                              ),
                            ),
                            MPHeight(10),
                            Text(
                              "투표한 안건이 적어서 국회\n의원을 추천하기 어려워요",
                              textAlign: .center,
                              style: Pretendard.medium.set(
                                size: 16,
                                height: 1.45,
                                color: ColorStyles.white,
                              ),
                            ),
                            MPHeight(6),
                            Text(
                              "더 많은 안건을 투표하면 나와 유사한\n성향의 국회의원을 추천해 드릴게요.",
                              textAlign: .center,
                              style: Pretendard.medium.set(
                                size: 14,
                                height: 1.45,
                                color: ColorStyles.gray30,
                              ),
                            ),
                            MPHeight(20),
                            Center(
                              child: Container(
                                height: 32.h,
                                padding: .symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  borderRadius: .circular(8.r),
                                  border: .all(
                                    width: 1.r,
                                    color: ColorStyles.gray50,
                                  ),
                                  color: ColorStyles.gray70,
                                ),
                                child: Row(
                                  mainAxisSize: .min,
                                  children: [
                                    Text(
                                      "안건 투표하기",
                                      style: Pretendard.semiBold.set(
                                        size: 14,
                                        color: ColorStyles.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    MPHeight(50),
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Text(
                            "${agendaDetail.category.categoryName}과 관련된\n다른 안건들 더 보기",
                            style: Pretendard.semiBold.set(
                              size: 20,
                              height: 1.35,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            ref.read(mainPageProvider.notifier).update(0);
                            ref.read(categoriesProvider.notifier).update([
                              agendaCategory,
                            ]);
                            context.pop();
                          },
                          child: Row(
                            children: [
                              Text(
                                "더보기",
                                style: Pretendard.medium.set(
                                  size: 14,
                                  color: ColorStyles.gray30,
                                ),
                              ),
                              MPSvgImage(
                                SvgImage.arrowRight,
                                size: 16,
                                color: ColorStyles.gray30,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    MPHeight(22),
                    SizedBox(
                      height: 32.h,
                      child: MPSingleScroll(
                        scrollDirection: .horizontal,
                        child: Row(
                          spacing: 8.w,
                          children: SimilarTopicSort.values
                              .map(
                                (sort) => MPChip(
                                  text: sort.label,
                                  isActive: selectedSort.value == sort,
                                  onTap: () => selectedSort.value = sort,
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    MPHeight(20),
                    for (var i = 0; i < similarTopicBills.length; i++) ...[
                      if (i > 0) MPHeight(6),
                      AgendaDetailSimilarTopicItem(
                        item: similarTopicBills.elementAt(i),
                        onTap: () {
                          final billId = similarTopicBills.elementAt(i).billId;
                          if (billId == null) return;

                          final router = context.router;
                          final detailRoutes = router.stackData
                              .where(
                                (data) => data.name == AgendaDetailRoute.name,
                              )
                              .toList();

                          if (detailRoutes.length >= 2) {
                            router.removeRoute(detailRoutes.first);
                          }

                          router.push(
                            AgendaDetailRoute(
                              key: Key("agenda_$billId"),
                              id: billId,
                            ),
                          );
                        },
                      ),
                    ],
                    MPHeight(12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaDetailSimilarTopicItem extends ConsumerWidget {
  final SimilarTopicBillResponse item;
  final void Function() onTap;

  const AgendaDetailSimilarTopicItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matches = ref
        .watch(appCategoriesProvider)
        .where((category) => category.code == item.categoryCode);
    final category = matches.isEmpty ? null : matches.first;

    return GestureDetector(
      onTap: onTap,
      behavior: .translucent,
      child: SizedBox(
        height: 112.h,
        child: Row(
          spacing: 12.w,
          children: [
            if (category != null)
              Container(
                width: 80.r,
                height: 80.r,
                decoration: BoxDecoration(
                  color: category.colorBackground,
                  borderRadius: .circular(8.r),
                ),
                child: Center(
                  child: MPNetworkImage(category.iconUrl, size: 40),
                ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: .stretch,
                mainAxisAlignment: .center,
                children: [
                  Text(
                    item.officialTitle?.wrapped ?? "",
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Pretendard.medium.set(
                      size: 16,
                      height: 1.45,
                      color: ColorStyles.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AgendaVoteProgress extends StatelessWidget {
  final String text;
  final int percent;
  final bool vote;
  final void Function()? onTap;

  const AgendaVoteProgress({
    super.key,
    required this.text,
    required this.percent,
    required this.vote,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: percent.clamp(0, 100).toDouble()),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutSine,
        builder: (context, animatedPercent, _) {
          final displayPercent = animatedPercent.round();
          final widthFactor = animatedPercent / 100;

          return SizedBox(
            height: 51.h,
            child: Stack(
              fit: .expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: .circular(8.r),
                    color: ColorStyles.gray80,
                  ),
                ),

                ClipRRect(
                  borderRadius: .circular(8.r),
                  child: FractionallySizedBox(
                    widthFactor: widthFactor,
                    alignment: .centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: vote ? null : ColorStyles.gray50,
                        gradient: vote
                            ? LinearGradient(
                                colors: [
                                  ColorStyles.primary50,
                                  ColorStyles.primary20,
                                ],
                              )
                            : null,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 20.w,
                  child: Center(
                    child: Text(
                      "$text $displayPercent%",
                      style: Pretendard.semiBold.set(
                        size: 16,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: .circular(8.r),
                  child: FractionallySizedBox(
                    widthFactor: widthFactor,
                    alignment: .centerLeft,
                    child: SizedBox.expand(
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 20.w,
                            child: Center(
                              child: Text(
                                "$text $displayPercent%",
                                maxLines: 1,
                                style: Pretendard.semiBold.set(
                                  size: 16,
                                  color: vote
                                      ? ColorStyles.black
                                      : ColorStyles.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AgedaDeailtStepOrder extends StatelessWidget {
  final int uiStepOrder;
  final String uiStepName;
  final bool isActive;

  const AgedaDeailtStepOrder({
    super.key,
    required this.uiStepOrder,
    required this.uiStepName,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4.w,
      children: [
        Container(
          height: 18.r,
          width: 18.r,
          decoration: BoxDecoration(
            borderRadius: .circular(3.r),
            color: isActive ? ColorStyles.primary50 : ColorStyles.gray60,
          ),
          alignment: .center,
          child: Text(
            "$uiStepOrder",
            textAlign: .center,
            style: Pretendard.semiBold.set(
              size: 14,
              color: isActive ? ColorStyles.gray80 : ColorStyles.gray70,
            ),
          ),
        ),
        Text(
          uiStepName,
          style: Pretendard.semiBold.set(
            size: 15,
            color: isActive ? ColorStyles.primary10 : ColorStyles.gray30,
          ),
        ),
      ],
    );
  }
}
