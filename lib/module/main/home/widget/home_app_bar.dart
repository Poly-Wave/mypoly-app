import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/widget/common/horizontal_padding.dart';
import 'package:mypoly/provider/router_provider.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorStyles.black,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: HorizontalPadding(
        child: Row(
          children: [
            Text(
              '홈',
              style: Pretendard.semiBold.set(
                size: 24,
                color: ColorStyles.white,
              ),
            ),

            Spacer(),

            GestureDetector(
              onTap: () {},
              child: MPSvgImage(SvgImage.icSearch, width: 32, height: 32),
            ),

            SizedBox(width: 8),

            GestureDetector(
              onTap: () => context.pushRoute(NotificationRoute()),
              child: MPSvgImage(SvgImage.icNotice, width: 32, height: 32),
            ),
          ],
        ),
      ),
    );
  }
}
