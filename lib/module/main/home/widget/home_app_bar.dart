import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mypoly/asset/index.dart';
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
      backgroundColor: Colors.black,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Text(
            '홈',
            style: Pretendard.semiBold.set(size: 24, color: ColorStyles.white),
          ),

          Spacer(),

          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8),
              child: MPSvgImage(SvgImage.icSearch, width: 24, height: 24),
            ),
          ),
          GestureDetector(
            onTap: () => context.pushRoute(NotificationRoute()),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: MPSvgImage(SvgImage.icNotice, width: 24, height: 24),
            ),
          ),
        ],
      ),
    );
  }
}
