import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/enum/sort.dart';
import 'package:mypoly/generate/bills/model/agenda_tab_response.dart';
import 'package:mypoly/module/main/home/main_home_provider.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/module/main/home/model/popular_subsidy_item.dart';
import 'package:mypoly/module/main/home/widget/popular_subsidy_card.dart';
import 'package:mypoly/module/widget/carousel/horizontal_carousel.dart';
import 'package:mypoly/module/main/home/widget/agenda_intro_item.dart';
import 'package:mypoly/module/main/home/widget/favorite_agenda_item.dart';

@RoutePage()
class MainHomeView extends HookConsumerWidget {
  const MainHomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorStyles.black,
      child: ListView(
        children: [
          NoticeSection(), // 공지사항

          MyInfoSection(), // 내 정보

          AgendaIntroSection(), // 안건 소개

          FavoriteTopicSection(),
        ],
      ),
    );
  }
}

// 공지사항
class NoticeSection extends StatelessWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(color: ColorStyles.divider),
      child: Padding(
        padding: .symmetric(horizontal: 20.w),
        child: Row(
          children: [
            MPSvgImage(SvgImage.noticeSectionLogo, size: 24),

            SizedBox(width: 10.w),

            Expanded(
              child: Text(
                '북마크한 보조금 신청기간입니다.',
                style: Pretendard.medium.set(
                  size: 15,
                  color: ColorStyles.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(width: 10.w),

            GestureDetector(
              onTap: () {
                // 공지 상세 이동
              },
              child: MPSvgImage(SvgImage.arrowRight, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}

// 내 정보
class MyInfoSection extends StatelessWidget {
  const MyInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Padding(
            padding: .symmetric(vertical: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: Pretendard.semiBold.set(
                        size: 25,
                        height: 1.3,
                        color: ColorStyles.white,
                      ),
                      children: [
                        TextSpan(text: "안녕하세요\n"),
                        TextSpan(
                          text: "동글동글한너구리",
                          style: Pretendard.semiBold
                              .set(size: 25, height: 1.3)
                              .copyWith(
                                foreground: Paint()
                                  ..shader = LinearGradient(
                                    colors: [
                                      ColorStyles.primary40,
                                      ColorStyles.primary10,
                                    ],
                                  ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
                              ),
                        ),
                        TextSpan(text: "님"),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: () => context.pushRoute(MyInfoRoute()),
                  child: Container(
                    padding: .symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: ColorStyles.gray70,
                      borderRadius: .circular(8.r),
                      border: Border.all(color: ColorStyles.gray60),
                    ),
                    child: Text(
                      "내정보 보기",
                      style: Pretendard.medium.set(
                        size: 13,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Row(
            spacing: 10.w,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => context.pushRoute(BookmarkRoute()),
                  child: MPImage(WebpImage.btnMainHomeBookmark, fit: .fitWidth),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => context.pushRoute(VoteRoute()),
                  child: MPImage(WebpImage.btnMainHomeVote, fit: .fitWidth),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// 안건 소개
class AgendaIntroSection extends HookConsumerWidget {
  const AgendaIntroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabs = ref.watch(appAgendaTabsProvider);

    if (tabs.isEmpty) {
      return SizedBox.shrink();
    }

    final selectedTab = useState<AgendaTabResponse>(tabs.first);
    final userCategories = ref.watch(appUserCategoriesProvider);
    final appTabAgendas = ref.watch(appTabAgendasProvider);
    final tabAgendas = appTabAgendas
        .firstWhere((tabAgendas) => tabAgendas.$1 == selectedTab.value)
        .$2;

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        MPHeight(50),
        Container(
          height: 47.h,
          padding: .symmetric(horizontal: 20.w),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "다양한 안건 소개",
                  style: Pretendard.semiBold.set(
                    size: 20,
                    color: ColorStyles.gray10,
                  ),
                ),
              ),

              GestureDetector(
                onTap: () {
                  // 더보기 기능
                },
                behavior: HitTestBehavior.translucent,
                child: Row(
                  spacing: 4.w,
                  children: [
                    Text(
                      "더보기",
                      style: Pretendard.medium.set(
                        size: 14,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPSvgImage(SvgImage.arrowRight, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 56.h,
          child: MPSingleScroll(
            scrollDirection: .horizontal,
            child: Padding(
              padding: .symmetric(horizontal: 20.w),
              child: Row(
                spacing: 8.w,
                children: tabs.map((item) {
                  final isSelected = selectedTab.value == item;

                  return GestureDetector(
                    onTap: () => selectedTab.value = item,
                    child: MPChip(
                      text: item.label,
                      isActive: isSelected,
                      onTap: () => selectedTab.value = item,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        MPHeight(10),

        Padding(
          padding: .symmetric(horizontal: 20.w),
          child: userCategories.isEmpty
              ? CategoryEmptyView()
              : ListView.separated(
                  key: ValueKey(selectedTab.value),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tabAgendas.length,
                  separatorBuilder: (context, index) => Container(
                    height: 1.h,
                    margin: .symmetric(vertical: 24.h),
                    color: ColorStyles.gray80,
                  ),
                  itemBuilder: (context, index) {
                    final item = tabAgendas.elementAt(index);

                    return AgendaIntroItem(
                      index: index,
                      item: item,
                      onTap: () {},
                    );
                  },
                ),
        ),
      ],
    );
  }
}

// 관심 주제 안건
class FavoriteTopicSection extends HookConsumerWidget {
  const FavoriteTopicSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = useState<MPSort>(.popular);
    final appInterestAgendas = ref.watch(appInterestAgendasProvider);
    final interestAgendas = sort.value == .popular
        ? appInterestAgendas.$1
        : appInterestAgendas.$2;
    final userCategories = ref.watch(appUserCategoriesProvider);

    return Padding(
      padding: .symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MPHeight(50),
          SizedBox(
            height: 47.h,
            child: Row(
              children: [
                Text(
                  "관심 주제 안건",
                  style: Pretendard.semiBold.set(
                    size: 20,
                    color: ColorStyles.white,
                  ),
                ),
                Spacer(),
                MPSortSwitch(
                  value: sort.value,
                  onChanged: (value) => sort.value = value,
                ),
              ],
            ),
          ),

          if (userCategories.isEmpty)
            CategoryEmptyView()
          else
            ListView.separated(
              key: ValueKey(sort.value),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: interestAgendas.length,
              separatorBuilder: (context, index) => SizedBox(height: 6.h),
              itemBuilder: (context, index) {
                final item = interestAgendas.elementAt(index);

                return FavoriteAgendaItem(item: item, onTap: () {});
              },
            ),
        ],
      ),
    );
  }
}

// 인기 보조금
class PopularSubsidySection extends StatelessWidget {
  const PopularSubsidySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopularSubsidy> dummyPopularSubsidies = [
      PopularSubsidy(
        status: '예정',
        applyPeriod: '접수기간별 상이',
        remainingPeriod: '30일 전',
        title: '근로 장려금',
        description: '근로 중인 20대라면?\n최대 수백만 원, 정부가 지원합니다.',
        subsidyAmount: '165',
      ),

      PopularSubsidy(
        status: '예정',
        applyPeriod: '접수기간별 상이',
        remainingPeriod: '30일 전',
        title: '근로 장려금',
        description: '근로 중인 20대라면?\n최대 수백만 원, 정부가 지원합니다.',
        subsidyAmount: '165',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              '역삼2동', // TODO - 지역명
              style: Pretendard.semiBold.set(
                size: 20,
                color: ColorStyles.primary50,
              ),
            ),

            Text(
              ' 인기 보조금 혜택',
              style: Pretendard.semiBold.set(
                size: 20,
                color: ColorStyles.white,
              ),
            ),

            Spacer(),

            GestureDetector(
              onTap: () {
                // TODO - 더보기 이동
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: Pretendard.medium.set(
                      size: 14,
                      color: ColorStyles.gray30,
                    ),
                  ),
                  SizedBox(width: 4),
                  MPSvgImage(SvgImage.arrowRight, size: 16),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        HorizontalCarousel(
          height: 200,
          items: List.generate(dummyPopularSubsidies.length, (index) {
            final data = dummyPopularSubsidies[index];

            return Padding(
              padding: EdgeInsets.only(
                right: index == dummyPopularSubsidies.length - 1 ? 0 : 20,
              ),
              child: PopularSubsidyCard(data: data),
            );
          }),
        ),
      ],
    );
  }
}

class CategoryEmptyView extends StatelessWidget {
  const CategoryEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      decoration: BoxDecoration(
        color: ColorStyles.divider,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MPImage(WebpImage.emptySearch, size: 64),
          MPHeight(10),
          Column(
            children: [
              Text(
                "관심 있는 주제를 선택해주세요",
                style: Pretendard.medium.set(
                  size: 16,
                  color: ColorStyles.white,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "동글동글한너구리님이\n관심 갖고 있는 주제 위주로 볼 수 있어요.",
                textAlign: TextAlign.center,
                style: Pretendard.medium
                    .set(size: 14, color: ColorStyles.gray30)
                    .copyWith(height: 1.45),
              ),
            ],
          ),
          MPHeight(20),
          GestureDetector(
            onTap: () => context.pushRoute(TopicRoute()),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 32.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: ColorStyles.gray70,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: ColorStyles.gray50, width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "관심 주제 선택",
                    style: Pretendard.semiBold.set(
                      size: 14,
                      color: ColorStyles.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
