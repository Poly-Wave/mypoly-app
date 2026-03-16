import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/module/main/home/widget/agenda_intro_item.dart';

class AgendaIntroSection extends HookConsumerWidget {
  const AgendaIntroSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final agendaItems =
        useState<List<(int, String, int, int, int, VoidCallback)>>([]);

    useEffect(() {
      // 안건 리스트 요청(서버)

      agendaItems.value = [
        (1, "소득세법 일부개정법률안(대안)(기획재정위원장)", 90, 10, 500, () {}),
        (2, "소득세법 일부개정법률안(대안)(기획재정위원장)", 99, 1, 500, () {}),
      ];

      return null;
    }, []);

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

        Padding(
          padding: .symmetric(vertical: 12.h),
          child: Row(
            children:
                [
                  ("쟁쟁한", true),
                  ("맞춤형", false),
                  ("요즘 핫한", false),
                  ("이번달 인기", false),
                ].map((item) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: AgendaCategoryButton(item: item),
                  );
                }).toList(),
          ),
        ),

        Padding(
          padding: .only(top: 12.h),
          child: Column(
            children: agendaItems.value.map((item) {
              return Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: AgendaIntroItem(item: item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class AgendaCategoryButton extends StatelessWidget {
  final (String, bool) item;

  const AgendaCategoryButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 32.h,
        padding: .symmetric(horizontal: 12.w, vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: .circular(99.r),
          border: Border.all(
            color: item.$2 ? ColorStyles.primary50 : ColorStyles.gray60,
          ),
        ),
        child: Text(
          item.$1,
          maxLines: 1,
          softWrap: false,
          style: Pretendard.medium.set(
            size: 13,
            color: item.$2 ? ColorStyles.primary60 : ColorStyles.gray20,
          ),
        ),
      ),
    );
  }
}
