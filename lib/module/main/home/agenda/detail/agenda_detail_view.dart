import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/main/home/agenda/detail/agenda_detail_provider.dart';
import 'package:mypoly/module/main/widget/agenda.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/util/extension.dart';
import 'package:mypoly/widget/index.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';
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
      ],
      child: AgendaDetailView(),
    );
  }
}

class AgendaDetailView extends HookConsumerWidget {
  const AgendaDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaDetail = ref.watch(agendaDetailProvider);

    useEffect(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        ref.read(agendaDetailProvider.notifier).fetch();
      });

      return null;
    }, []);

    if (agendaDetail == null) {
      return Scaffold(
        appBar: MPAppBar(context, text: "의안 상세"),
        body: MPSafeBox(bottom: true, child: Center(child: MPLoading())),
      );
    }

    final agendaCategory = ref.watch(agendaCategoryProvider(agendaDetail));

    return Scaffold(
      appBar: MPAppBar(context, text: "의안 상세"),
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
                      child: Row(children: []),
                    ),
                    MPHeight(20),
                    AspectRatio(
                      aspectRatio: 320 / 140,
                      child: Container(
                        decoration: BoxDecoration(
                          color: agendaCategory.colorBackground,
                          borderRadius: .circular(12.r),
                        ),
                        alignment: .center,
                        child: MPNetworkImage(agendaCategory.iconUrl, size: 80),
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
                            MPSvgImage(SvgImage.arrowRight, size: 16),
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
                      ],
                    ),
                    MPHeight(20),
                    MPButton(
                      "응원해요",
                      style: .gray,
                      height: 51,
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
                      textStyle: Pretendard.medium.set(
                        size: 16,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(20),
                    Center(
                      child: Container(
                        height: 32.h,
                        padding: .symmetric(horizontal: 10.w),
                        child: Text(
                          "투표하고 결과보기",
                          style: Pretendard.semiBold.set(
                            size: 14,
                            color: ColorStyles.gray20,
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
                    MPHeight(50),
                    Row(
                      crossAxisAlignment: .center,
                      children: [
                        Expanded(
                          child: Text(
                            "디지털과 관련된\n다른 안건들 더 보기",
                            style: Pretendard.semiBold.set(
                              size: 20,
                              height: 1.35,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    MPHeight(22),
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
