import 'package:auto_route/auto_route.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/enum/age_band.dart';
import 'package:mypoly/enum/gender.dart';
import 'package:mypoly/module/main/home/agenda/detail/agenda_detail_provider.dart'
    as detail;
import 'package:mypoly/module/main/home/agenda/detail/agenda_detail_view.dart';
import 'package:mypoly/module/main/home/agenda/vote/agenda_vote_provider.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/format.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/overlay/index.dart';

@RoutePage()
class AgendaVoteProviderView extends StatelessWidget {
  final int id;

  const AgendaVoteProviderView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        detail.agendaIdProvider.overrideWithValue(id),
        detail.agendaDetailProvider.overrideWith(detail.AgendaDetail.new),
        agendaIdProvider.overrideWithValue(id),
        voteDetailProvider.overrideWith(VoteDetail.new),
      ],
      child: AgendaVoteView(),
    );
  }
}

class AgendaVoteView extends HookConsumerWidget {
  const AgendaVoteView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nickname = ref.watch(appUserNicknameProvider);
    final agendaDetail = ref.watch(detail.agendaDetailProvider);
    final voteDetail = ref.watch(voteDetailProvider);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(detail.agendaDetailProvider.notifier).fetch();
        ref.read(voteDetailProvider.notifier).fetch();
      });

      return null;
    }, []);

    if (agendaDetail == null || voteDetail == null) {
      return Scaffold(
        appBar: MPAppBar(context, text: "투표 결과"),
        body: MPSafeBox(bottom: true, child: Center(child: MPLoading())),
      );
    }

    final voteSummary = agendaDetail.voteSummary;
    final isDisagree = voteSummary.myVoteResult == "DISAGREE";
    final selectedPercent =
        ((isDisagree ? voteSummary.disagreeRatio : voteSummary.agreeRatio) *
                100)
            .round();
    final selectedCount = isDisagree
        ? voteSummary.disagreeCount
        : voteSummary.agreeCount;
    final selectedLabel = isDisagree ? "아쉬워했어요" : "응원했어요";

    return Scaffold(
      appBar: MPAppBar(
        context,
        text: "투표 결과",
        right: MPBookmark(
          checked: agendaDetail.bookmarked,
          onTap: () => ref
              .read(detail.agendaDetailProvider.notifier)
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
                padding: .symmetric(vertical: 10.h, horizontal: 20.w),
                child: MPSafeColumn(
                  bottom: true,
                  crossAxisAlignment: .stretch,
                  children: [
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Text(
                            "투표 $selectedPercent%가\n$nickname님과\n같은 의견이에요",
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
                      AgendaVoteProgress(
                        text: '응원해요',
                        percent: (agendaDetail.voteSummary.agreeRatio * 100)
                            .round(),
                        vote: agendaDetail.voteSummary.myVoteResult == "AGREE",
                      ),
                      MPHeight(10),
                      AgendaVoteProgress(
                        text: '아쉬워요',
                        percent: (agendaDetail.voteSummary.disagreeRatio * 100)
                            .round(),
                        vote:
                            agendaDetail.voteSummary.myVoteResult == "DISAGREE",
                      ),
                    ] else ...[
                      MPButton(
                        "응원해요",
                        style: .gray,
                        height: 51,
                        onTap: () => ref
                            .read(detail.agendaDetailProvider.notifier)
                            .vote(true),
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
                        onTap: () => ref
                            .read(detail.agendaDetailProvider.notifier)
                            .vote(false),
                        textStyle: Pretendard.medium.set(
                          size: 16,
                          color: ColorStyles.white,
                        ),
                      ),
                    ],
                    MPHeight(10),
                    Text(
                      "총 ${Format.num.format(voteSummary.totalVoteCount)}명 중 ${Format.num.format(selectedCount)}명이 $selectedLabel.",
                      style: Pretendard.medium.set(
                        size: 15,
                        height: 1.45,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPHeight(40),
                    Text(
                      "투표 참여한 성별",
                      style: Pretendard.medium.set(
                        size: 20,
                        height: 1.35,
                        color: ColorStyles.gray10,
                      ),
                    ),
                    MPHeight(20),
                    Container(
                      height: 265.h,
                      decoration: BoxDecoration(
                        borderRadius: .circular(12.r),
                        border: .all(width: 1.r, color: ColorStyles.gray60),
                        color: ColorStyles.gray80,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 2.h),
                            blurRadius: 10.r,
                            color: Color(0x290B0C0C),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: .symmetric(vertical: 20.h),
                        child: AgendaVoteDonutChart(
                          sections: [
                            for (final g in voteDetail.genderBreakdown)
                              AgendaVoteDonutSection(
                                label: g.gender.label,
                                count: g.count,
                                color: g.gender.color,
                                gradient: g.gender.gradient,
                              ),
                          ],
                        ),
                      ),
                    ),
                    MPHeight(40),
                    Text(
                      "투표 참여한 연령대",
                      style: Pretendard.medium.set(
                        size: 20,
                        height: 1.35,
                        color: ColorStyles.gray10,
                      ),
                    ),
                    MPHeight(20),
                    for (final a in voteDetail.ageBandBreakdown) ...[
                      AgendaVoteAgeBar(
                        label: a.ageBand.label,
                        percent: (a.ratio * 100).round(),
                      ),
                      MPHeight(10),
                    ],
                    MPHeight(10),
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

class AgendaVoteDonutSection {
  final String label;
  final int count;
  final Color color;
  final Gradient gradient;

  const AgendaVoteDonutSection({
    required this.label,
    required this.count,
    required this.color,
    required this.gradient,
  });
}

class AgendaVoteDonutChart extends StatelessWidget {
  final List<AgendaVoteDonutSection> sections;

  const AgendaVoteDonutChart({super.key, required this.sections});

  @override
  Widget build(BuildContext context) {
    final total = sections.fold<int>(0, (sum, s) => sum + s.count);

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: .center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 1.r,
                  centerSpaceRadius: 45.r,
                  startDegreeOffset: -90,
                  sections: [
                    for (final s in sections)
                      PieChartSectionData(
                        value: s.count.toDouble(),
                        gradient: s.gradient,
                        radius: 45.r,
                        showTitle: false,
                        badgePositionPercentageOffset: 0.7,
                        badgeWidget: _AgendaVotePercentBadge(
                          color: s.color,
                          percent: total == 0
                              ? 0
                              : (s.count / total * 100).round(),
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: .min,
                children: [
                  MPSvgImage(SvgImage.voteGender, size: 24),
                  MPHeight(2),
                  Text(
                    "${Format.num.format(total)}명\n투표",
                    textAlign: .center,
                    style: Pretendard.semiBold.set(
                      size: 13,
                      height: 1.4,
                      color: ColorStyles.gray30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        MPHeight(10),
        Row(
          mainAxisAlignment: .center,
          spacing: 12.w,
          children: [
            for (final s in sections)
              Row(
                mainAxisSize: .min,
                spacing: 6.w,
                children: [
                  Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(shape: .circle, color: s.color),
                  ),
                  Text(
                    s.label,
                    style: Pretendard.medium.set(
                      size: 13,
                      height: 1.4,
                      color: ColorStyles.gray30,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

class _AgendaVotePercentBadge extends StatelessWidget {
  final Color color;
  final int percent;

  const _AgendaVotePercentBadge({required this.color, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28.h,
      padding: .symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: .circular(4.r),
        color: ColorStyles.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1.h),
            blurRadius: 6.r,
            color: const Color(0x21262929),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: .min,
        spacing: 4.w,
        children: [
          Container(
            width: 8.r,
            height: 8.r,
            decoration: BoxDecoration(shape: .circle, color: color),
          ),
          Text(
            "$percent%",
            style: Pretendard.semiBold.set(
              size: 14,
              letterSpacing: -0.68,
              color: ColorStyles.gray80,
            ),
          ),
        ],
      ),
    );
  }
}

class AgendaVoteAgeBar extends StatelessWidget {
  final String label;
  final int percent;

  const AgendaVoteAgeBar({
    super.key,
    required this.label,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: percent.clamp(0, 100).toDouble()),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutSine,
      builder: (context, animatedPercent, _) {
        final displayPercent = animatedPercent.round();
        final widthFactor = (animatedPercent / 100).clamp(0.0, 1.0);

        return SizedBox(
          height: 39.h,
          child: Stack(
            fit: .expand,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: .circular(8.r),
                  color: ColorStyles.gray80,
                ),
              ),
              _AgendaVoteAgeBarLabels(
                label: label,
                percent: displayPercent,
                color: ColorStyles.white,
              ),
              ClipRRect(
                borderRadius: .circular(8.r),
                child: ClipRect(
                  clipper: _AgendaVoteBarWidthClipper(widthFactor),
                  child: Stack(
                    fit: .expand,
                    children: [
                      Container(color: ColorStyles.primary40),
                      _AgendaVoteAgeBarLabels(
                        label: label,
                        percent: displayPercent,
                        color: ColorStyles.black,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AgendaVoteAgeBarLabels extends StatelessWidget {
  final String label;
  final int percent;
  final Color color;

  const _AgendaVoteAgeBarLabels({
    required this.label,
    required this.percent,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final style = Pretendard.semiBold.set(size: 16, color: color);

    return Stack(
      fit: .expand,
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 20.w,
          child: Center(child: Text(label, style: style)),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 20.w,
          child: Center(child: Text("$percent%", style: style)),
        ),
      ],
    );
  }
}

class _AgendaVoteBarWidthClipper extends CustomClipper<Rect> {
  final double factor;

  const _AgendaVoteBarWidthClipper(this.factor);

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * factor, size.height);

  @override
  bool shouldReclip(_AgendaVoteBarWidthClipper oldClipper) =>
      oldClipper.factor != factor;
}
