import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';
import 'package:collection/collection.dart';
import 'package:mypoly/module/widget/common/horizontal_padding.dart';
import 'package:mypoly/generate/bills/api/agenda_api.dart';
import 'package:mypoly/data/provider/dio_provider.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/generate/bills/api/category_api.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/generate/bills/model/popular_agenda_response.dart';
import '../agenda/widget/collapsed_row.dart';
import '../agenda/widget/expanded_list.dart';
import 'dart:async';

@RoutePage()
class MainAgendaView extends HookConsumerWidget {
  const MainAgendaView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: ColorStyles.black,
      child: ListView(
        children: [
          HorizontalPadding(
            child: Column(
              children: [
                _RealtimePopularAgendaSection(),
                SizedBox(height: 20.h),
                _AgendaListSection(),
              ],
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
        child: Container(
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

const sortOptions = ['최신순', '인기순'];
const categoryOptions = ['지역', '주제'];
const fieldOptions = ['주제', '제목', '내용', '썸네일', '등록일자', '조회수', '투표수'];

class _AgendaListSection extends HookConsumerWidget {
  const _AgendaListSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendas = useState<List<dynamic>>([]);

    final sort = useState('최신순');
    final category = useState('지역');
    final field = useState('주제');

    final appCategories = ref.watch(appCategoriesProvider);
    final categoryCodes = useState<List<String>>([]);

    useEffect(() {
      if (appCategories.isEmpty) {
        return null;
      }
      Future(() async {
        try {
          final dio = ref.read(dioProvider);
          final api = AgendaApi(
            dio,
            baseUrl: ref.read(envProvider).billsApiUrl,
          );

          final List<String> targetCodes = categoryCodes.value.isNotEmpty
              ? categoryCodes.value
              : appCategories.map((e) => e.code.toString()).toList();

          final result = await api.getMainAgendas(
            page: 0,
            size: 10,
            sortType: _mapSort(sort.value),
            categoryCodes: targetCodes,
          );

          agendas.value = (result.content ?? []) as List<dynamic>;
        } catch (e) {
          debugPrint('메인 안건 조회 실패: $e');
        }
      });

      return null;
    }, [sort.value, categoryCodes.value]);

    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, sort),
          SizedBox(height: 12.h),
          _buildFilterRow(
            context,
            ref,
            category,
            field,
            appCategories,
            categoryCodes,
          ),

          SizedBox(height: 16.h),

          Column(
            children: List.generate(agendas.value.length, (i) {
              final item = agendas.value[i];

              return Column(
                children: [
                  if (i != 0)
                    Center(
                      child: Container(
                        width: 320.w,
                        height: 1.h,
                        color: ColorStyles.divider,
                      ),
                    ),

                  AgendaListItem(
                    category: item.categoryName ?? '',
                    title: item.title ?? '',
                    date: _formatDate(item.registeredDate ?? ''),
                    viewCount: item.viewCount ?? 0,
                    voteCount: item.voteCount ?? 0,
                    thumbnail: _buildThumbnail(
                      item.categoryIconUrl ?? '',
                      item.categoryBackgroundColor ?? 'FFFFFF',
                    ),
                    categoryBackgroundColor: item.categoryBackgroundColor,
                    categoryTextColor: item.categoryTextColor,
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  String _mapSort(String sortLabel) {
    switch (sortLabel) {
      case '인기순':
        return 'POPULAR';
      case '최신순':
      default:
        return 'LATEST';
    }
  }

  void _openTopicBottomSheet(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> appCategories,
    ValueNotifier<List<String>> confirmedCodes,
  ) {
    showMPBottomSheetModal(
      context,
      children: [
        const MPBottomSheetCloseHeader(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: HookBuilder(
            builder: (context) {
              final initialConfirmedCodes = useState<List<String>>([]);
              final categoryStates = useState<List<(bool, dynamic)>>([]);

              useEffect(() {
                Future(() async {
                  try {
                    final dio = ref.read(dioProvider);
                    final api = CategoryApi(
                      dio,
                      baseUrl: ref.read(envProvider).billsApiUrl,
                    );

                    final List<CategoryResponse> serverInterests = await api
                        .getMyInterests();

                    final List<String> interestCodes = serverInterests
                        .map((e) => e.code.toString())
                        .toList();

                    initialConfirmedCodes.value = interestCodes;
                    confirmedCodes.value = interestCodes;

                    categoryStates.value = appCategories.map((cat) {
                      final bool isSelected = interestCodes.contains(cat.code);
                      return (isSelected, cat);
                    }).toList();
                  } catch (e) {
                    debugPrint('관심 카테고리 서버 조회 실패: $e');
                    initialConfirmedCodes.value = confirmedCodes.value;
                    categoryStates.value = appCategories.map((cat) {
                      final bool isSelected = confirmedCodes.value.contains(
                        cat.code,
                      );
                      return (isSelected, cat);
                    }).toList();
                  }
                });
                return null;
              }, []);

              final currentSelectedCodes = categoryStates.value
                  .where((item) => item.$1)
                  .map((item) => item.$2.code as String)
                  .toList();

              final bool isChanged = !const DeepCollectionEquality.unordered()
                  .equals(initialConfirmedCodes, currentSelectedCodes);

              final bool isApplyActive = isChanged;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "주제별",
                    style: Pretendard.semiBold.set(
                      size: 16,
                      color: ColorStyles.white,
                    ),
                  ),
                  MPHeight(16),

                  Wrap(
                    spacing: 10.w,
                    runSpacing: 10.h,
                    children: [
                      _buildChip(
                        label: "전체",
                        isSelected: currentSelectedCodes.isEmpty,
                        onTap: () {
                          categoryStates.value = categoryStates.value
                              .map((item) => (false, item.$2))
                              .toList();
                        },
                      ),
                      ...categoryStates.value.mapIndexed((index, item) {
                        return _buildChip(
                          label: item.$2.name ?? '',
                          isSelected: item.$1,
                          onTap: () {
                            final tmp = [...categoryStates.value];
                            tmp[index] = (!item.$1, item.$2);
                            categoryStates.value = tmp;
                          },
                        );
                      }),
                    ],
                  ),
                  MPHeight(40),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          categoryStates.value = appCategories.map((cat) {
                            final bool isSelected = initialConfirmedCodes.value
                                .contains(cat.code);
                            return (isSelected, cat);
                          }).toList();
                        },
                        child: Container(
                          width: 150.w,
                          height: 57.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: ColorStyles.gray60,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "초기화",
                            style: Pretendard.semiBold.set(
                              size: 18,
                              color: ColorStyles.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      GestureDetector(
                        onTap: () {
                          if (!isApplyActive) return;
                          final selectedItems = categoryStates.value.where(
                            (item) => item.$1,
                          );
                          confirmedCodes.value = selectedItems
                              .map((item) => item.$2.code as String)
                              .toList();
                          context.pop();
                        },
                        child: Container(
                          width: 150.w,
                          height: 57.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 16.h,
                          ),
                          decoration: BoxDecoration(
                            color: isApplyActive
                                ? ColorStyles.primary50
                                : ColorStyles.gray70,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            "적용",
                            style: Pretendard.semiBold.set(
                              size: 18,
                              color: isApplyActive
                                  ? ColorStyles.black
                                  : ColorStyles.gray60,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
        MPHeight(20),
      ],
    );
  }

  Widget _buildChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(
          top: 6.h,
          bottom: 6.h,
          left: 12.w,
          right: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: isSelected ? ColorStyles.primary50 : ColorStyles.gray60,
            width: 1.r,
          ),
        ),
        child: Text(
          label,
          style: Pretendard.semiBold.set(
            size: 14,
            color: isSelected ? ColorStyles.primary60 : ColorStyles.gray20,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
  }

  Widget _buildThumbnail(String url, String bgColor) {
    final color = Color(int.parse('0xFF$bgColor'));

    return Container(
      color: color,
      child: Center(
        child: Image.network(
          url,
          width: 32,
          height: 32,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Icon(Icons.image, size: 32),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ValueNotifier<String> sort) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '의안리스트',
          style: Pretendard.semiBold.set(size: 20, color: ColorStyles.gray10),
        ),
        _buildSortButtons(sort),
      ],
    );
  }

  Widget _buildFilterRow(
    BuildContext context,
    WidgetRef ref,
    ValueNotifier<String> category,
    ValueNotifier<String> field,
    List<dynamic> appCategories,
    ValueNotifier<List<String>> categoryCodes,
  ) {
    return Row(
      children: [
        /// AI추천
        Container(
          width: 62,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorStyles.primary50, ColorStyles.primary20],
            ),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'AI추천',
            style: Pretendard.semiBold.set(
              size: 14,
              color: ColorStyles.primary100,
            ),
          ),
        ),

        SizedBox(width: 8),

        /// 필터 버튼 - 주제
        GestureDetector(
          onTap: () =>
              _openTopicBottomSheet(context, ref, appCategories, categoryCodes),
          child: _outlineButton('주제'),
        ),
      ],
    );
  }

  Widget _outlineButton(String label) {
    return Container(
      height: 32,
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: ColorStyles.gray20),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: Pretendard.semiBold.set(size: 14, color: ColorStyles.gray20),
          ),
          SizedBox(width: 4),
          MPSvgImage(SvgImage.arrowDown, width: 18),
        ],
      ),
    );
  }
}

Widget _buildSortButtons(ValueNotifier<String> sort) {
  return Row(
    children: [
      _sortButton(
        label: '인기순',
        isSelected: sort.value == '인기순',
        onTap: () => sort.value = '인기순',
      ),
      SizedBox(width: 4),
      _sortButton(
        label: '최신순',
        isSelected: sort.value == '최신순',
        onTap: () => sort.value = '최신순',
      ),
    ],
  );
}

Widget _sortButton({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 44,
      height: 20,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? ColorStyles.primary20 : ColorStyles.divider,
        borderRadius: BorderRadius.circular(4),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: Pretendard.semiBold.set(
            size: 12,
            height: 1,
            color: isSelected ? ColorStyles.gray70 : ColorStyles.gray40,
          ),
        ),
      ),
    ),
  );
}

class AgendaListItem extends StatelessWidget {
  final String category;
  final String title;
  final String date;
  final int viewCount;
  final int voteCount;
  final Widget thumbnail;
  final String categoryBackgroundColor;
  final String categoryTextColor;

  const AgendaListItem({
    super.key,
    required this.category,
    required this.title,
    required this.date,
    required this.viewCount,
    required this.voteCount,
    required this.thumbnail,
    required this.categoryBackgroundColor,
    required this.categoryTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 카테고리
                    Container(
                      height: 22.h,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Color(int.parse('0xFF$categoryBackgroundColor')),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            category,
                            style: Pretendard.semiBold.set(
                              size: 12,
                              color: Color(int.parse('0xFF$categoryTextColor')),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 10),

                    /// 타이틀
                    SizedBox(
                      width: 244.w,
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Pretendard.medium.set(
                          size: 16,
                          color: ColorStyles.white,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12),

              /// 이미지
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(width: 64, height: 64, child: thumbnail),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// 날짜
              Text(
                date,
                style: Pretendard.medium.set(
                  size: 13,
                  color: ColorStyles.gray30,
                ),
              ),

              Row(
                children: [
                  /// 조회수
                  MPImage(WebpImage.viewCount, width: 14.03, height: 9.6),
                  SizedBox(width: 4),
                  Text(
                    viewCount.toString(),
                    style: Pretendard.medium.set(
                      size: 13,
                      color: ColorStyles.gray30,
                    ),
                  ),

                  SizedBox(width: 8),

                  /// 투표수
                  MPImage(WebpImage.voteCount, width: 16),
                  SizedBox(width: 4),
                  Text(
                    voteCount.toString(),
                    style: Pretendard.medium.set(
                      size: 13,
                      color: ColorStyles.gray30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
