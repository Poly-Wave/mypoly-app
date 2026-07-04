part of 'index.dart';

class MPRadio extends StatelessWidget {
  final bool checked;
  final void Function()? onTap;
  final double size;

  const MPRadio({super.key, this.checked = true, this.onTap, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: checked ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorRadioOff, size: size),
          ),
          AnimatedOpacity(
            opacity: checked ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorRadioOn, size: size),
          ),
        ],
      ),
    );
  }
}

class MPCheckBoxCircle extends StatelessWidget {
  final bool checked;
  final void Function()? onTap;
  final double size;

  const MPCheckBoxCircle({
    super.key,
    this.checked = true,
    this.onTap,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: checked ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorCheckboxCircleOff, size: size),
          ),
          AnimatedOpacity(
            opacity: checked ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorCheckboxCircleOn, size: size),
          ),
        ],
      ),
    );
  }
}

class MPCheckMark extends StatelessWidget {
  final bool checked;
  final void Function()? onTap;
  final double size;

  const MPCheckMark({
    super.key,
    this.checked = true,
    this.onTap,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: checked ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorCheckmarkOff, size: size),
          ),
          AnimatedOpacity(
            opacity: checked ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorCheckmarkOn, size: size),
          ),
        ],
      ),
    );
  }
}

class MPBookmark extends StatelessWidget {
  final bool checked;
  final void Function()? onTap;
  final double size;

  const MPBookmark({
    super.key,
    this.checked = true,
    this.onTap,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          AnimatedOpacity(
            opacity: checked ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorBookmarkOff, size: size),
          ),
          AnimatedOpacity(
            opacity: checked ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: MPSvgImage(SvgImage.selectorBookmarkOn, size: size),
          ),
        ],
      ),
    );
  }
}
