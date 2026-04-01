import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/module/main/home/model/popular_subsidy_item.dart';

class PopularSubsidyCard extends StatelessWidget {
  final PopularSubsidy data;

  const PopularSubsidyCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264,
      height: 200,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.4,
          colors: [ColorStyles.white, ColorStyles.primary10],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorStyles.gray70,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  data.status, // 진행상태
                  maxLines: 1,
                  style: Pretendard.medium.set(
                    size: 14,
                    color: ColorStyles.white,
                  ),
                ),
              ),

              SizedBox(width: 8),

              Text(
                data.applyPeriod, // 접수기간
                style: Pretendard.semiBold.set(
                  size: 15,
                  color: ColorStyles.divider,
                ),
              ),

              Spacer(),

              Text(
                data.remainingPeriod,
                style: Pretendard.semiBold.set(
                  size: 13,
                  color: ColorStyles.gray50,
                ),
              ),
            ],
          ),

          SizedBox(height: 15),

          Text(
            data.title, // 제목
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Pretendard.semiBold.set(
              size: 18,
              color: ColorStyles.divider,
            ),
          ),

          SizedBox(height: 15),

          Text(
            data.description, // 설명
            overflow: TextOverflow.ellipsis,
            style: Pretendard.medium.set(
              size: 15,
              height: 1.4,
              color: ColorStyles.divider,
            ),
          ),

          Spacer(),

          Align(
            alignment: Alignment.bottomRight,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '최대 ',
                    style: Pretendard.semiBold.set(
                      size: 20,
                      color: ColorStyles.black,
                    ),
                  ),
                  TextSpan(
                    text: '${data.subsidyAmount}만원',
                    style: Pretendard.semiBold.set(
                      size: 20,
                      color: ColorStyles.primary50,
                    ),
                  ),
                  TextSpan(
                    text: ' 지급',
                    style: Pretendard.semiBold.set(
                      size: 20,
                      color: ColorStyles.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
