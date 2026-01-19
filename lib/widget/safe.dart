part of 'index.dart';

class MPSafeBox extends SafeArea {
  const MPSafeBox({
    super.key,
    super.left = false,
    super.top = false,
    super.right = false,
    super.bottom = false,
    super.minimum,
    super.maintainBottomViewPadding,
    super.child = const SizedBox.shrink(),
  });
}

class MPSafeColumn extends Column {
  final bool top;
  final bool bottom;

  MPSafeColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    super.spacing,
    required List<Widget> children,
    this.top = false,
    this.bottom = false,
  }) : super(
         children: [
           if (top) const MPSafeBox(top: true),
           ...children,
           if (bottom) const MPSafeBox(bottom: true),
         ],
       );
}
