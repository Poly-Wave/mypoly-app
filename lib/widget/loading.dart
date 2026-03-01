part of 'index.dart';

class MPLoading extends HookWidget {
  final int size;

  const MPLoading({super.key, this.size = 80});

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(milliseconds: 1200),
    );

    final rotation = Tween<double>(
      begin: 0,
      end: -1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    useEffect(() {
      controller.repeat();

      return null;
    }, []);

    return RotationTransition(
      turns: rotation,
      child: MPImage(WebpImage.loading, size: 80),
    );
  }
}
