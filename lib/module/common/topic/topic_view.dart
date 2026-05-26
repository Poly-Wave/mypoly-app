import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mypoly/data/provider/service_provider.dart';
import 'package:mypoly/generate/bills/model/category_response.dart';
import 'package:mypoly/provider/app_provider.dart';
import 'package:mypoly/provider/app_user_provider.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/widget/modal/index.dart';

@RoutePage()
class TopicView extends HookConsumerWidget {
  final bool isOnboard;

  const TopicView({super.key, this.isOnboard = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appCategories = ref.read(appCategoriesProvider);
    final appUserCategories = ref.read(appUserCategoriesProvider);

    final categories = useState(
      isOnboard
          ? appCategories.map((category) => (false, category)).toList()
          : appCategories
                .map(
                  (category) =>
                      (appUserCategories.contains(category), category),
                )
                .toList(),
    );

    final onNextEnabled =
        categories.value.firstWhereOrNull((item) => item.$1) != null;

    final allChecked = !categories.value.map((item) => item.$1).contains(false);

    return Scaffold(
      appBar: MPAppBar(context, isBackEnabled: !isOnboard, text: "관심주제 선택"),
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

                          categories.value = [
                            ...categories.value,
                          ].map((item) => (newChecked, item.$2)).toList();
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
                            tmp[index] = (!item.$1, item.$2);
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
            onTap: () async {
              context.loaderOverlay.show();

              final selectedCategories = categories.value
                  .where((data) => data.$1)
                  .map((data) => data.$2)
                  .toList();

              try {
                if (isOnboard) {
                  await ref
                      .read(categoryServiceProvider)
                      .updateCategories(
                        categories: selectedCategories,
                        isOnboard: isOnboard,
                      );
                } else {
                  await ref
                      .read(appUserProvider.notifier)
                      .updateCategories(selectedCategories);
                }

                if (!context.mounted) return;
                context.loaderOverlay.hide();
                if (isOnboard) {
                  context.replaceRoute(RegisterMoreRoute());
                } else {
                  context.pop();
                }
              } catch (e) {
                context.loaderOverlay.hide();
                showMPAlertModal(
                  context,
                  title: "관심주제 선택에 실패하였습니다.\n잠시 후 다시 시도해 주세요.",
                );
              }
            },
            children: [
              MPHeight(4),
              Padding(
                padding: .symmetric(horizontal: 20.w),
                child: GestureDetector(
                  onTap: () async {
                    if (isOnboard) {
                      context.loaderOverlay.show();

                      try {
                        await ref
                            .read(userServiceProvider)
                            .updateOnboardStatus(.category);

                        if (!context.mounted) return;
                        context.loaderOverlay.hide();
                        context.replaceRoute(RegisterMoreRoute());
                      } catch (e) {
                        context.loaderOverlay.hide();
                        context.replaceRoute(RegisterMoreRoute());
                      }
                    } else {
                      context.pop();
                    }
                  },
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
  final (bool, CategoryResponse) item;
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
                  child: MPNetworkImage(item.$2.iconUrl, size: 40),
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
            item.$2.name,
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
