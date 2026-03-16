import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

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
                      const TextSpan(text: "안녕하세요\n"),
                      TextSpan(
                        text: "동글동글한너구리",
                        style: Pretendard.semiBold
                            .set(size: 25, height: 1.3)
                            .copyWith(
                              foreground: Paint()
                                ..shader =
                                    const LinearGradient(
                                      colors: [
                                        ColorStyles.primary40,
                                        ColorStyles.primary10,
                                      ],
                                    ).createShader(
                                      const Rect.fromLTWH(0, 0, 200, 70),
                                    ),
                            ),
                      ),
                      const TextSpan(text: "님"),
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
          children: [
            Expanded(
              child: MyInfoButton(
                item: ("보관함", SvgImage.homeStore, ColorStyles.white, () {}),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: MyInfoButton(
                item: ("참여투표", SvgImage.homeVote, ColorStyles.white, () {}),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyInfoButton extends StatelessWidget {
  final (String, String, Color, void Function()) item;

  const MyInfoButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.$4,
      child: Container(
        padding: EdgeInsets.all(1.5),
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: .circular(10.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFA5FFEF), Color(0xFF256D86)],
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: .circular(10.r),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFA5FFEF), Color(0xFF256D86)],
            ),
          ),
          child: Row(
            mainAxisAlignment: .center,
            spacing: 8.w,
            children: [
              MPSvgImage(item.$2, size: 24),
              Text(
                item.$1,
                style: Pretendard.semiBold.set(
                  size: 14,
                  color: ColorStyles.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
