import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/provider/app_user_provider.dart';

@RoutePage()
class DeleteAccountView extends HookConsumerWidget {
  const DeleteAccountView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAgreed = useState(false);
    final reasonList = [
      '사용하는 빈도가 낮아요',
      '원하는 기능이 없어요',
      '사용방법이 어렵고 불편해요',
      '결과물 품질이 기대와 달라요',
      '다른 유사 서비스를 이용해요',
      '기타',
    ];
    final selectedIndices = useState<List<bool>>(
      List.generate(reasonList.length, (_) => false),
    );

    final textController = useTextEditingController();
    final textLength = useState(0);
    useEffect(() {
      void listener() => textLength.value = textController.text.length;
      textController.addListener(listener);
      return () => textController.removeListener(listener);
    }, [textController]);

    return Scaffold(
      appBar: MPAppBar(context, text: "탈퇴"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MPHeight(20),
                    Text(
                      '마이폴리를\n정말 탈퇴하시겠어요?',
                      style: Pretendard.semiBold.set(
                        size: 28,
                        color: ColorStyles.white,
                        height: 1.35,
                      ),
                    ),
                    MPHeight(6),

                    Text(
                      '탈퇴 전 아래 안내 사항을 꼭 확인해 주세요.',
                      style: Pretendard.medium.set(
                        size: 18,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPHeight(20),

                    Container(
                      width: 320.w,
                      height: 200.h,
                      padding: EdgeInsets.all(20.r),
                      decoration: BoxDecoration(
                        color: ColorStyles.gray70,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Center(
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '유의사항',
                                style: Pretendard.medium.set(
                                  size: 15,
                                  color: ColorStyles.white,
                                ),
                              ),
                              MPHeight(8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '• ',
                                          style: Pretendard.regular.set(
                                            size: 15,
                                            color: ColorStyles.gray10,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '탈퇴를 신청하면 즉시 탈퇴 처리되며, 계정과 데이터가 바로 삭제돼요.',
                                            style: Pretendard.regular
                                                .set(
                                                  size: 15,
                                                  color: ColorStyles.gray10,
                                                )
                                                .copyWith(height: 1.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    MPHeight(10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '• ',
                                          style: Pretendard.regular.set(
                                            size: 15,
                                            color: ColorStyles.gray10,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '탈퇴 후 7일이 지나면 다시 가입할 수 있어요.',
                                            style: Pretendard.regular
                                                .set(
                                                  size: 15,
                                                  color: ColorStyles.gray10,
                                                )
                                                .copyWith(height: 1.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                    MPHeight(10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '• ',
                                          style: Pretendard.regular.set(
                                            size: 15,
                                            color: ColorStyles.gray10,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '탈퇴하면 보관 중인 이미지·생성 기록이 모두 삭제되며, 복구할 수 없어요.',
                                            style: Pretendard.regular
                                                .set(
                                                  size: 15,
                                                  color: ColorStyles.gray10,
                                                )
                                                .copyWith(height: 1.3),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    MPHeight(16),

                    GestureDetector(
                      onTap: () => isAgreed.value = !isAgreed.value,
                      behavior: HitTestBehavior.translucent,
                      child: Container(
                        width: 320.w,
                        height: 52.h,
                        child: CustomPaint(
                          painter: isAgreed.value
                              ? _GradientBorderPainter(
                                  strokeWidth: 1.r,
                                  gradient: LinearGradient(
                                    colors: [
                                      ColorStyles.primary50,
                                      ColorStyles.primary20,
                                    ],
                                  ),
                                  radius: 8.r,
                                )
                              : null,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                              horizontal: 20.w,
                            ),
                            decoration: BoxDecoration(
                              color: ColorStyles.gray70,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MPSvgImage(
                                  isAgreed.value
                                      ? SvgImage.selectorCheckmarkOn
                                      : SvgImage.selectorCheckmarkOff,
                                  width: 24.w,
                                  height: 24.h,
                                ),
                                MPWidth(6),
                                Text(
                                  '위 유의사항을 모두 확인했어요',
                                  style: Pretendard.medium.set(
                                    size: 16,
                                    color: ColorStyles.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    MPHeight(60),
                    Text(
                      '탈퇴하시는 이유를 알려주세요.',
                      style: Pretendard.semiBold.set(
                        size: 20,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(6),
                    Text(
                      '더 나은 마이폴리를 만드는 데 큰 도움이 돼요.\n(중복 선택)',
                      style: Pretendard.medium.set(
                        size: 15,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPHeight(20),

                    HookBuilder(
                      builder: (context) {
                        return Column(
                          children: List.generate(reasonList.length, (index) {
                            final isSelected = selectedIndices.value[index];

                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    final updated = [...selectedIndices.value];
                                    updated[index] = !updated[index];
                                    selectedIndices.value = updated;
                                  },
                                  behavior: HitTestBehavior.translucent,
                                  child: Container(
                                    width: 320.w,
                                    height: 46.h,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                      horizontal: 20.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        MPSvgImage(
                                          isSelected
                                              ? SvgImage.selectorCheckmarkOn
                                              : SvgImage.selectorCheckmarkOff,
                                          width: 20.w,
                                          height: 20.h,
                                        ),
                                        MPWidth(6),

                                        Text(
                                          reasonList[index],
                                          style: Pretendard.medium.set(
                                            size: 15,
                                            color: ColorStyles.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (index < reasonList.length - 1) MPHeight(6),
                                if (reasonList[index] == '기타' &&
                                    isSelected) ...[
                                  MPHeight(6),
                                  Container(
                                    width: 320.w,
                                    height: 100.h,
                                    padding: EdgeInsets.symmetric(
                                      vertical: 14.h,
                                      horizontal: 16.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ColorStyles.divider,
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    child: TextField(
                                      controller: textController,
                                      maxLines: null,
                                      maxLength: 200,
                                      cursorColor: ColorStyles.primary60,
                                      enableSuggestions: false,
                                      autocorrect: false,
                                      style: Pretendard.medium.set(
                                        size: 16,
                                        color: ColorStyles.white,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: '불편했던 점이나 바라는 점을 자유롭게 남겨주세요.',
                                        hintStyle: Pretendard.medium.set(
                                          size: 16,
                                          color: ColorStyles.gray60,
                                        ),
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        counterText: '',
                                      ),
                                    ),
                                  ),
                                  MPHeight(4),

                                  SizedBox(
                                    width: 320.w,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${textLength.value}/200',
                                        style: Pretendard.medium.set(
                                          size: 14,
                                          color: ColorStyles.gray50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            );
                          }),
                        );
                      },
                    ),

                    MPHeight(50),
                    HookBuilder(
                      builder: (context) {
                        final isButtonEnabled =
                            isAgreed.value &&
                            selectedIndices.value.contains(true);

                        return GestureDetector(
                          onTap: isButtonEnabled
                              ? () {
                                  ref
                                      .read(appUserProvider.notifier)
                                      .withdrawMe(
                                        reasons: List.generate(
                                          reasonList.length,
                                          (index) {
                                            if (!selectedIndices.value[index]) {
                                              return null;
                                            }

                                            switch (reasonList[index]) {
                                              case '사용하는 빈도가 낮아요':
                                                return 'INFREQUENT_USE';
                                              case '원하는 기능이 없어요':
                                                return 'MISSING_FEATURE';
                                              case '사용방법이 어렵고 불편해요':
                                                return 'HARD_TO_USE';
                                              case '결과물 품질이 기대와 달라요':
                                                return 'LOW_QUALITY';
                                              case '다른 유사 서비스를 이용해요':
                                                return 'USING_ALTERNATIVE';
                                              case '기타':
                                                return 'ETC';
                                              default:
                                                return null;
                                            }
                                          },
                                        ).whereType<String>().toList(),
                                        etcText: textController.text,
                                      );
                                }
                              : null,
                          behavior: HitTestBehavior.translucent,
                          child: Container(
                            width: 320.w,
                            height: 57.h,
                            margin: EdgeInsets.only(
                              top: 20.h,
                              bottom:
                                  20.h + MediaQuery.of(context).padding.bottom,
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isButtonEnabled
                                  ? ColorStyles.primary50
                                  : ColorStyles.gray70,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              '탈퇴하기',
                              style: Pretendard.semiBold.set(
                                size: 18,
                                color: isButtonEnabled
                                    ? ColorStyles.black
                                    : ColorStyles.gray60,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
