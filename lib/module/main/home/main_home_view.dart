import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/module/widget/common/horizontal_padding.dart';
import 'package:mypoly/module/main/home/model/popular_subsidy_item.dart';
import 'package:mypoly/module/main/home/widget/popular_subsidy_card.dart';
import 'package:mypoly/module/widget/carousel/horizontal_carousel.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/generate/bills/model/pageable.dart';
import 'package:mypoly/data/provider/dio_provider.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/module/main/home/widget/agenda_intro_item.dart';
import 'package:mypoly/module/main/home/widget/agenda_category_button.dart';
import 'package:mypoly/module/main/home/widget/sort_button.dart';
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
          HorizontalPadding(
            child: Column(
              children: [
                MyInfoSection(), // 내 정보

                MPHeight(50),

                AgendaIntroSection(), // 안건 소개

                MPHeight(50),

                FavoriteTopicSection(), // 관심 주제 안건
                //PopularSubsidySection(), // 인기 보조금
              ],
            ),
          ),
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
    return Column(
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
    );
  }
}

// 안건 소개
class AgendaIntroSection extends HookConsumerWidget {
  const AgendaIntroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaItems =
        useState<List<(int, String, int, int, int, VoidCallback)>>([]);

    final selectedTab = useState<String?>(null);
    final categories = useState<List<(String code, String label)>>([]);

    useEffect(() {
      // 카테고리 조회(서버)
      Future(() async {
        try {
          final dio = ref.read(dioProvider);
          final api = AgendaApi(
            dio,
            baseUrl: ref.read(envProvider).billsApiUrl,
          );

          final result = await api.getTabs();

          categories.value = result
              .map<(String, String)>((e) => (e.code ?? '', e.label ?? ''))
              .toList();
          if (categories.value.isNotEmpty && selectedTab.value == null) {
            selectedTab.value = categories.value.first.$1;
          }
        } catch (e) {
          debugPrint('카테고리 조회 실패: $e');
        }
      });

      return null;
    }, []);

    useEffect(() {
      // 안건 리스트 요청(서버)

      // agendaItems.value = [
      //   (1, "소득세법 일부개정법률안(대안)(기획재정위원장)", 90, 10, 500, () {}),
      //   (2, "소득세법 일부개정법률안(대안)(기획재정위원장)", 99, 1, 500, () {}),
      // ];
      if (selectedTab.value == null) return null;

      Future(() async {
        try {
          final dio = ref.read(dioProvider);
          final api = AgendaApi(
            dio,
            baseUrl: ref.read(envProvider).billsApiUrl,
          );
          final result = await api.getAgendasByTab(
            tabCode: selectedTab.value!,
            pageable: Pageable(page: 0, size: 10),
          );

          agendaItems.value = result.asMap().entries.map((entry) {
            final index = entry.key;
            final e = entry.value;

            final agree = ((e.agreeRatio ?? 0) * 100).toInt();
            final disagree = ((e.disagreeRatio ?? 0) * 100).toInt();

            return (
              index + 1,
              e.officialTitle ?? '',
              agree,
              disagree,
              e.totalVoteCount ?? 0,
              () {},
            );
          }).toList();
        } catch (e) {
          debugPrint('안건 조회 실패: $e');
        }
      });

      return null;
    }, [selectedTab.value]);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: .symmetric(vertical: 10.h),
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

        if (categories.value.isNotEmpty)
          Padding(
            padding: .symmetric(vertical: 12.h),
            child: Row(
              children: categories.value.map((item) {
                final code = item.$1;
                final label = item.$2;
                final isSelected = selectedTab.value == code;

                return Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: GestureDetector(
                    onTap: () {
                      selectedTab.value = code;
                    },
                    child: AgendaCategoryButton(item: (label, isSelected)),
                  ),
                );
              }).toList(),
            ),
          ),

        Padding(
          padding: EdgeInsets.only(top: 12.h),
          child: agendaItems.value.isEmpty
              ? ListEmptyView()
              : Column(
                  children: List.generate(agendaItems.value.length, (index) {
                    final item = agendaItems.value[index];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (index != 0) SizedBox(height: 24.h),

                        if (index != 0)
                          Center(
                            child: Container(
                              width: 320.w,
                              height: 1,
                              color: ColorStyles.divider,
                            ),
                          ),

                        if (index != 0) SizedBox(height: 24.h),

                        AgendaIntroItem(item: item),
                      ],
                    );
                  }),
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
    final selectedSortIndex = useState(0);

    final favoriteAgendas = List.generate(3, (index) => index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: 47.h,
          padding: EdgeInsets.symmetric(vertical: 10.h),
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
              Row(
                children: [
                  SortButton(
                    label: "인기순",
                    isSelected: selectedSortIndex.value == 0,
                    onTap: () => selectedSortIndex.value = 0,
                  ),
                  SizedBox(width: 4.w),
                  SortButton(
                    label: "최신순",
                    isSelected: selectedSortIndex.value == 1,
                    onTap: () => selectedSortIndex.value = 1,
                  ),
                ],
              ),
            ],
          ),
        ),

        favoriteAgendas.isEmpty
            ? ListEmptyView()
            : ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: favoriteAgendas.length,
                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                itemBuilder: (context, index) => FavoriteAgendaItem(),
              ),
      ],
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

class ListEmptyView extends StatelessWidget {
  const ListEmptyView({super.key});

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

          SizedBox(height: 10.h),
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

          SizedBox(height: 20.h),
          GestureDetector(
            onTap: () {},
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
