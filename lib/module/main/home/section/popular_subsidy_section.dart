import 'package:flutter/material.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/module/widget/carousel/horizontal_carousel.dart';
import 'package:mypoly/module/main/home/model/popular_subsidy_item.dart';
import 'package:mypoly/module/main/home/widget/popular_subsidy_card.dart';

class PopularSubsidySection extends StatelessWidget {
  const PopularSubsidySection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PopularSubsidy> dummyPopularSubsidies = [
      PopularSubsidy(
        status: '예정',
        applyPeriod: '접수기간별 상이',
        remainingPeriod: '30일 전',
        title: '근로 장려금',
        description: '근로 중인 20대라면?\n최대 수백만 원, 정부가 지원합니다.',
        subsidyAmount: '165',
      ),

      PopularSubsidy(
        status: '예정',
        applyPeriod: '접수기간별 상이',
        remainingPeriod: '30일 전',
        title: '근로 장려금',
        description: '근로 중인 20대라면?\n최대 수백만 원, 정부가 지원합니다.',
        subsidyAmount: '165',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              '역삼2동', // TODO - 지역명
              style: Pretendard.semiBold.set(
                size: 20,
                color: ColorStyles.primary50,
              ),
            ),

            Text(
              ' 인기 보조금 혜택',
              style: Pretendard.semiBold.set(
                size: 20,
                color: ColorStyles.white,
              ),
            ),

            Spacer(),

            GestureDetector(
              onTap: () {
                // TODO - 더보기 이동
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  Text(
                    '더보기',
                    style: Pretendard.medium.set(
                      size: 14,
                      color: ColorStyles.gray30,
                    ),
                  ),
                  SizedBox(width: 4),
                  MPSvgImage(SvgImage.arrowRight, size: 16),
                ],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),

        HorizontalCarousel(
          height: 200,
          items: List.generate(dummyPopularSubsidies.length, (index) {
            final data = dummyPopularSubsidies[index];

            return Padding(
              padding: EdgeInsets.only(
                right: index == dummyPopularSubsidies.length - 1 ? 0 : 20,
              ),
              child: PopularSubsidyCard(data: data),
            );
          }),
        ),
      ],
    );
  }
}
