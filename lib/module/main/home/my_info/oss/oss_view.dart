import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mypoly/oss_licenses.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class OSSView extends HookConsumerWidget {
  const OSSView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: MPAppbar(context, text: "오픈소스 라이선스"),
      body: ListView.separated(
        itemCount: dependencies.length,
        padding: .zero,
        separatorBuilder: (context, index) => Container(
          margin: .symmetric(horizontal: 20.w),
          height: 1.h,
          color: ColorStyles.divider,
        ),
        itemBuilder: (context, index) {
          final item = dependencies[index];

          final child = GestureDetector(
            onTap: () {
              final url = item.repository ?? item.homepage;

              if (url != null) {
                launchUrlString(url);
              }
            },
            child: Padding(
              padding: .symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.name,
                          style: Pretendard.semiBold.set(
                            size: 15,
                            height: 1.45,
                            color: ColorStyles.white,
                          ),
                        ),
                      ),
                      if (item.version != null)
                        Text(
                          item.version ?? "",
                          style: Pretendard.regular.set(
                            size: 14,
                            height: 1.45,
                            color: ColorStyles.gray30,
                          ),
                        ),
                    ],
                  ),
                  MPHeight(4),
                  Text(
                    item.description,
                    style: Pretendard.regular.set(
                      size: 14,
                      height: 1.45,
                      color: ColorStyles.gray30,
                    ),
                  ),
                  if (item.spdxIdentifiers.isNotEmpty) ...[
                    MPHeight(8),
                    Text(
                      item.spdxIdentifiers.join(', '),
                      style: Pretendard.regular.set(
                        size: 12,
                        height: 1.45,
                        color: ColorStyles.gray20,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );

          if (index == dependencies.length - 1) {
            return MPSafeBox(bottom: true, child: child);
          }

          return child;
        },
      ),
    );
  }
}
