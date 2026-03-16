import 'package:flutter/material.dart';
import 'package:mypoly/module/widget/carousel/carousel_indicator.dart';

class HorizontalCarousel extends StatefulWidget {
  final List<Widget> items;
  final double height;
  final double viewportFraction;
  final bool showIndicator;

  const HorizontalCarousel({
    super.key,
    required this.items,
    required this.height,
    this.viewportFraction = 0.85,
    this.showIndicator = true,
  });

  @override
  State<HorizontalCarousel> createState() => HorizontalCarouselState();
}

class HorizontalCarouselState extends State<HorizontalCarousel> {
  late final PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = PageController(viewportFraction: widget.viewportFraction);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: controller,
            padEnds: false,
            itemCount: widget.items.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return widget.items[index];
            },
          ),
        ),

        if (widget.showIndicator) ...[
          SizedBox(height: 12),
          CarouselIndicator(
            count: widget.items.length,
            currentIndex: currentIndex,
          ),
        ],
      ],
    );
  }
}
