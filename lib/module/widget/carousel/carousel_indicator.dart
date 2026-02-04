import 'package:flutter/material.dart';
import 'package:mypoly/style/index.dart';

class CarouselIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final double spacing;

  const CarouselIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final bool isActive = index == currentIndex;

        return Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(
            right: index == count - 1 ? 0 : 10,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive
                ? ColorStyles.primary50
                : ColorStyles.gray70,
          ),
        );
      }),
    );
  }
}