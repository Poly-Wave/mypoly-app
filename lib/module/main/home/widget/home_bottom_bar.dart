import 'package:flutter/material.dart';
import 'package:mypoly/asset/index.dart';
import 'package:mypoly/style/index.dart';
import 'package:mypoly/widget/index.dart';

class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 59,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
          child: Row(
            children: [
              Expanded(
                child: BottomActionButton(
                  item: ("안건", SvgImage.mainAgenda, () {}),
                ),
              ),
              Expanded(
                child: BottomActionButton(
                  item: ("홈", SvgImage.mainHome, () {}),
                ),
              ),
              Expanded(
                child: BottomActionButton(
                  item: ("보조금", SvgImage.mainSubsidy, () {}),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomActionButton extends StatelessWidget {
  final (String, String, void Function()) item;

  const BottomActionButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.$3,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MPSvgImage(
            item.$2,
            size: 20,
          ),

          const SizedBox(height: 6),

          Text(
            item.$1,
            style: Pretendard.medium.set(
              size: 12,
              color: ColorStyles.gray60,
            ),
          ),
        ],
      ),
    );
  }
}