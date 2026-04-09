import 'package:flutter/material.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/module/widget/common/horizontal_padding.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;

  const MainAppBar({super.key, required this.currentIndex});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  String get title {
    switch (currentIndex) {
      case 0:
        return '안건';
      case 1:
        return '홈';
      case 2:
        return '보조금';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorStyles.black,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: HorizontalPadding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Pretendard.semiBold.set(size: 24)),
            Row(
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: GestureDetector(
                    onTap: () {},
                    child: MPSvgImage(SvgImage.icSearch, size: 32),
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: GestureDetector(
                    onTap: () {},
                    child: MPSvgImage(SvgImage.icNotice, size: 32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
