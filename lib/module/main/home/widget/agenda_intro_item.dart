import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/generate/bills/model/agenda_response.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/module/main/home/widget/vote_progress_bar.dart';

/// 1. 순위
/// 2. 제목
/// 3. '응원해요' 퍼센트
/// 4. '아쉬워요' 퍼센트
/// 5. 투표수

class AgendaIntroItem extends StatelessWidget {
  final int index;
  final AgendaResponse item;
  final void Function() onTap;

  const AgendaIntroItem({
    super.key,
    required this.index,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          crossAxisAlignment: .start,
          spacing: 12.w,
          children: [
            Container(
              width: 42.r,
              height: 42.r,
              decoration: BoxDecoration(
                borderRadius: .circular(8.r),
                gradient: LinearGradient(
                  colors: [Color(0xFF2E5C66), Color(0xFF769999)],
                ),
                border: Border.all(color: ColorStyles.primary50),
              ),
              alignment: .center,
              child: Text(
                "${index + 1}위",
                style: Pretendard.semiBold.set(
                  size: 13,
                  letterSpacing: -0.104,
                  color: ColorStyles.white,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    item.officialTitle,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: Pretendard.medium.set(
                      size: 16,
                      height: 1.45,
                      color: ColorStyles.white,
                    ),
                  ),
                  Row(
                    spacing: 2.w,
                    children: [
                      Text(
                        "투표 완료",
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

        MPHeight(16),

        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              '응원해요 ${item.agreeRatio.toInt()}%',
              style: Pretendard.medium.set(
                size: 13,
                color: ColorStyles.primary50,
              ),
            ),
            Text(
              '아쉬워요 ${item.disagreeRatio.toInt()}%',
              style: Pretendard.medium.set(size: 13, color: ColorStyles.gray10),
            ),
          ],
        ),

        MPHeight(8),

        Stack(
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                color: ColorStyles.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),

            Container(
              width: (229 * 1),
              height: 8.h,
              decoration: BoxDecoration(
                color: ColorStyles.primary40,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),

        VoteProgressBar(item: (item.agreeRatio, item.disagreeRatio, () {})),

        MPHeight(8),

        Align(
          alignment: .centerRight,
          child: Text(
            "${item.totalVoteCount}명 투표",
            style: Pretendard.medium.set(size: 13, color: ColorStyles.gray40),
          ),
        ),
      ],
    );
  }
}
