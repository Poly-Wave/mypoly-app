import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class NoticeSection extends StatelessWidget {
  const NoticeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      padding: .symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: ColorStyles.gray80,
        borderRadius: .circular(8.r),
      ),
      child: Row(
        children: [
          MPSvgImage(
            SvgImage.noticeSectionLogo,
            size: 20,
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Text(
              '북마크한 보조금 신청기간입니다.',
              style: Pretendard.medium.set(
                size: 14,
                color: ColorStyles.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          SizedBox(width: 10.w),

          GestureDetector(
            onTap: () {
              // 공지 상세 이동
            },
            child: MPSvgImage(
              SvgImage.arrowRight,
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}