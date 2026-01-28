import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class RegisterTopicView extends HookConsumerWidget {
  const RegisterTopicView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = useState([
      (false, WebpImage.categoryBangtong, "디지털"),
      (false, WebpImage.categoryAuth, "보안"),
      (false, WebpImage.categoryBangtong, "방통"),

      (false, WebpImage.categoryEconomy, "경제"),
      (false, WebpImage.categoryEconomy, "부동산"),
      (false, WebpImage.categoryEconomy, "교통"),

      (false, WebpImage.categoryEconomy, "환경"),
      (false, WebpImage.categoryBangtong, "의료"),
      (false, WebpImage.categoryEconomy, "복지"),

      (false, WebpImage.categoryEconomy, "교육"),
      (false, WebpImage.categoryBangtong, "노동"),
      (false, WebpImage.categoryEconomy, "여성"),

      (false, WebpImage.categoryEconomy, "가족"),
      (false, WebpImage.categoryBangtong, "아동"),
      (false, WebpImage.categoryEconomy, "성범죄"),

      (false, WebpImage.categoryEconomy, "외교안보"),
      (false, WebpImage.categoryBangtong, "법·행정"),
    ]);

    final onNextEnabled =
        categories.value.firstWhereOrNull((item) => item.$1) != null;

    final allChecked = !categories.value.map((item) => item.$1).contains(false);

    return Scaffold(
      appBar: MPBackAppbar(context, text: "관심주제 선택"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: Padding(
                padding: .symmetric(vertical: 20.h, horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: .stretch,
                  children: [
                    Text(
                      "어떤 주제에 주로\n관심이 있으신가요?",
                      style: Pretendard.semiBold.set(
                        size: 28,
                        height: 1.3,
                        letterSpacing: -0.54,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(6),
                    Text(
                      "선택한 주제 위주로 AI가 요약해 드려요.",
                      style: Pretendard.medium.set(
                        size: 18,
                        height: 1.4,
                        color: ColorStyles.gray30,
                      ),
                    ),
                    MPHeight(20),
                    Align(
                      alignment: .centerRight,
                      child: GestureDetector(
                        onTap: () {
                          final newChecked = !allChecked;

                          categories.value = [...categories.value]
                              .map((item) => (newChecked, item.$2, item.$3))
                              .toList();
                        },
                        child: Row(
                          mainAxisSize: .min,
                          spacing: 6.w,
                          children: [
                            MPCheckBoxCircle(checked: allChecked, size: 18),
                            Text(
                              "모두 선택",
                              style: Pretendard.medium.set(
                                size: 15,
                                color: ColorStyles.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    MPHeight(20),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 34.w,
                        mainAxisSpacing: 0,
                        childAspectRatio: 84.r / (84.r + 54.h),
                      ),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: categories.value.length,
                      itemBuilder: (_, index) {
                        final item = categories.value.elementAt(index);

                        return TopicItem(
                          item: item,
                          onTap: () {
                            final tmp = [...categories.value];
                            tmp[index] = (!item.$1, item.$2, item.$3);
                            categories.value = tmp;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          MPBottomButton(
            "다 골랐어요",
            enabled: onNextEnabled,
            onTap: () {
              context.replaceRoute(RegisterMoreRoute());
            },
            children: [
              MPHeight(4),
              Padding(
                padding: .symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: context.pop,
                  child: Container(
                    height: 51,
                    alignment: .center,
                    child: Text(
                      "관심없어요",
                      style: Pretendard.semiBold.set(
                        size: 16,
                        color: ColorStyles.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TopicItem extends StatelessWidget {
  // 체크 여부, 이미지, 텍스트
  final (bool, String, String) item;
  final void Function() onTap;

  const TopicItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  decoration: BoxDecoration(
                    shape: .circle,
                    color: ColorStyles.gray80,
                    border: item.$1
                        ? .all(width: 1.r, color: ColorStyles.primary50)
                        : null,
                  ),
                  alignment: .center,
                  child: MPImage(item.$2, size: 40),
                ),
                Positioned(
                  left: 4.r,
                  bottom: 4.r,
                  child: AnimatedOpacity(
                    opacity: item.$1 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    child: MPCheckBoxCircle(size: 18),
                  ),
                ),
              ],
            ),
          ),
          MPHeight(8),
          Text(
            item.$3,
            textAlign: .center,
            style: Pretendard.medium.set(
              size: 15,
              height: 1.45,
              color: ColorStyles.white,
            ),
          ),
        ],
      ),
    );
  }
}
