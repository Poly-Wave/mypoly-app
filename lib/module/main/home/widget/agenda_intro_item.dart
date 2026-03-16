import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/module/main/home/widget/vote_progress_bar.dart';

/// 1. 순위
/// 2. 제목
/// 3. '응원해요' 퍼센트
/// 4. '아쉬워요' 퍼센트
/// 5. 투표수

class AgendaIntroItem extends StatelessWidget {
  final (int, String, int, int, int, void Function()) item;

  const AgendaIntroItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 14.h,
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: .start,
          spacing: 12.w,
          children: [
            Container(
              padding: .symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorStyles.primary50),
              ),
              child: Text(
                "${item.$1}위",
                style: Pretendard.semiBold.set(
                  size: 13,
                  color: ColorStyles.white,
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                spacing: 6.h,
                children: [
                  Text(
                    item.$2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Pretendard.medium.set(
                      size: 16,
                      color: ColorStyles.white,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "투표완료 · ",
                        style: Pretendard.medium.set(
                          size: 13,
                          color: ColorStyles.gray30,
                        ),
                      ),
                      Text(
                        "응원해요",
                        style: Pretendard.medium.set(
                          size: 13,
                          color: ColorStyles.gray30,
                        ),
                      ),
                      MPSvgImage(SvgImage.arrowRight, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        VoteProgressBar(item: (item.$3, item.$4, () {})),

        Text(
          "${item.$5}명 투표",
          style: Pretendard.medium.set(size: 13, color: ColorStyles.gray50),
        ),
      ],
    );
  }
}
