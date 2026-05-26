/* 
 * 안건 프로그레스 바
 */

import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';

/// 1. '응원해요' 퍼센트
/// 2. '아쉬워요' 퍼센트

class VoteProgressBar extends StatelessWidget {
  final (int, int, void Function()) item;

  const VoteProgressBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final int agree = item.$1;
    final int disagree = item.$2;

    final double ratio = (item.$1 / 100).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text(
              '응원해요 $agree%',
              style: Pretendard.medium.set(
                size: 13,
                color: ColorStyles.primary50,
              ),
            ),
            Text(
              '아쉬워요$disagree%',
              style: Pretendard.medium.set(size: 13, color: ColorStyles.gray10),
            ),
          ],
        ),

        SizedBox(height: 8),

        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorStyles.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),

                Container(
                  width: (229 * ratio),
                  height: 8,
                  decoration: BoxDecoration(
                    color: ColorStyles.primary40,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
