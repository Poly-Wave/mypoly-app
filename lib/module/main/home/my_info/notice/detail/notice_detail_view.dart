import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

@RoutePage()
class NoticeDetailView extends HookConsumerWidget {
  const NoticeDetailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPAppbar(context, text: "공지사항"),
      body: Column(
        crossAxisAlignment: .stretch,
        children: [
          Expanded(
            child: MPSingleScroll(
              child: Padding(
                padding: .symmetric(horizontal: 20.w),
                child: MPSafeColumn(
                  bottom: true,
                  children: [
                    SizedBox(
                      height: 92.h,
                      child: Column(
                        spacing: 4.h,
                        mainAxisAlignment: .center,
                        crossAxisAlignment: .stretch,
                        children: [
                          Text(
                            "[공지] 공지내용이 들어가는 자리입니다. 최대 2줄 가능합니다.",
                            maxLines: 2,
                            overflow: .ellipsis,
                            style: Pretendard.semiBold.set(
                              size: 15,
                              height: 1.45,
                              color: ColorStyles.white,
                            ),
                          ),
                          Text(
                            "2025.12.30",
                            style: Pretendard.regular.set(
                              size: 14,
                              height: 1.45,
                              color: ColorStyles.gray30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MPHeight(4),
                    Container(height: 1.h, color: ColorStyles.divider),
                    MPHeight(16),
                    Text(
                      "MYPOLY는 이번 업데이트를 통해 전반적인 사용성을 개선했습니다.\n\n서비스 진입 속도를 높이기 위해 메인 화면 로딩 방식을 변경했습니다. 디자인 시스템이 개편되어 버튼과 아이콘의 형태가 통일되었고 컬러 대비가 강화되었습니다.\n\n일부 구형 기기에서 발생하던 화면 밀림 현상을 수정했습니다. 알림 기능의 안정성이 향상되었으며 중요 공지 도달률이 높아졌습니다. 앱 전반의 속도와 반응성을 점검하고 최적화했습니다.\n\nMYPOLY는 앞으로도 더 나은 경험을 위해 지속적으로 개선을 이어가겠습니다.",
                      style: Pretendard.medium.set(
                        size: 15,
                        height: 1.45,
                        color: ColorStyles.white,
                      ),
                    ),
                    MPHeight(20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
