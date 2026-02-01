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
    final double ratio = (item.$1 / 100).clamp(0.0, 1.0);

    return SizedBox(
      height: 40,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth * ratio;

          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorStyles.white,
                  borderRadius: BorderRadius.circular(18),
                ),
              ),

              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: width,
                    height: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF5AFEFF),
                            Color(0xFFA5FEF0),
                          ],
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(18),
                          right: ratio == 1
                              ? Radius.circular(18)
                              : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '응원해요 ${item.$1}%',
                        style: Pretendard.semiBold.set(
                          size: 14,
                          color: ColorStyles.black,
                        ),
                      ),
                      Text(
                        '아쉬워요 ${item.$2}%',
                        style: Pretendard.semiBold.set(
                          size: 14,
                          color: ColorStyles.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}