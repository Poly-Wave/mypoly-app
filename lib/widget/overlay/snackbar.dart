part of 'index.dart';

void showMPSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 2),
  double bottomMargin = 20,
  double horizontalMargin = 20,
}) {
  MPSnackBarOverlay.show(
    context,
    duration: duration,
    bottomMargin: bottomMargin,
    leftMargin: horizontalMargin,
    rightMargin: horizontalMargin,
    text: message,
  );
}

class MPSnackbarController {
  Future<void> Function({bool animate})? _dismiss;

  Future<void> dismiss({bool animate = true}) async {
    await _dismiss?.call(animate: animate);
  }

  void _attach(Future<void> Function({bool animate}) dismiss) {
    _dismiss = dismiss;
  }

  void _detach() {
    _dismiss = null;
  }
}

class MPSnackbar extends HookWidget {
  final Widget content;
  final Duration duration;
  final VoidCallback? onDismissed;
  final MPSnackbarController? controller;

  const MPSnackbar({
    super.key,
    required this.content,
    this.duration = const Duration(seconds: 3),
    this.onDismissed,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 320),
      reverseDuration: const Duration(milliseconds: 220),
    );

    final slideAnimation = useMemoized(
      () => Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        ),
      ),
      [animationController],
    );

    final opacityAnimation = useMemoized(
      () => CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
      [animationController],
    );

    final autoDismissTimer = useRef<Timer?>(null);
    final isDismissing = useRef(false);
    final dragOffset = useState(0.0);

    Future<void> dismiss({bool animate = true}) async {
      if (isDismissing.value || !context.mounted) return;
      isDismissing.value = true;
      autoDismissTimer.value?.cancel();

      if (animate) {
        await animationController.reverse();
      }

      if (context.mounted) {
        onDismissed?.call();
      }
    }

    void startAutoDismissTimer(Duration duration) {
      autoDismissTimer.value?.cancel();
      autoDismissTimer.value = Timer(duration, () {
        unawaited(dismiss());
      });
    }

    useEffect(() {
      controller?._attach(dismiss);
      unawaited(animationController.forward());
      startAutoDismissTimer(duration);

      return () {
        autoDismissTimer.value?.cancel();
        controller?._detach();
      };
    }, [animationController, controller, duration]);

    void onPanUpdate(DragUpdateDetails details) {
      if (isDismissing.value) return;
      autoDismissTimer.value?.cancel();
      final nextOffset = dragOffset.value + details.delta.dy;
      dragOffset.value = nextOffset < 0 ? 0.0 : nextOffset;
    }

    void onPanEnd(DragEndDetails details) {
      if (isDismissing.value) return;

      if (dragOffset.value > 24) {
        unawaited(dismiss());
        return;
      }

      dragOffset.value = 0;
      startAutoDismissTimer(const Duration(milliseconds: 1600));
    }

    return Transform.translate(
      offset: Offset(0, dragOffset.value),
      child: SlideTransition(
        position: slideAnimation,
        child: FadeTransition(
          opacity: opacityAnimation,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onPanUpdate: onPanUpdate,
            onPanEnd: onPanEnd,
            child: content,
          ),
        ),
      ),
    );
  }
}

class MPSnackBarOverlay {
  static OverlayEntry? _currentEntry;
  static MPSnackbarController? _currentSnackbarController;

  static Future<void> show(
    BuildContext context, {
    String? text,
    Widget? content,
    Duration duration = const Duration(seconds: 3),
    double bottomMargin = 20,
    double leftMargin = 20,
    double rightMargin = 20,
  }) async {
    assert(text != null || content != null);
    final overlayState = Overlay.maybeOf(context, rootOverlay: true);
    if (overlayState == null) return;

    await _dismissCurrent(animate: false);

    final snackbarController = MPSnackbarController();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => _MPSnackbarOverlayView(
        snackbarController: snackbarController,
        duration: duration,
        content: content ?? _defaultContent(text ?? ""),
        bottomMargin: bottomMargin.h,
        leftMargin: leftMargin.w,
        rightMargin: rightMargin.w,
        onClosed: () {
          entry.remove();
          _clearCurrentIf(entry);
        },
      ),
    );

    _currentEntry = entry;
    _currentSnackbarController = snackbarController;
    overlayState.insert(entry);
  }

  static Future<void> hide({bool animate = true}) async {
    await _dismissCurrent(animate: animate);
  }

  static Future<void> _dismissCurrent({required bool animate}) async {
    final entry = _currentEntry;
    if (entry == null) return;

    final snackbarController = _currentSnackbarController;
    if (snackbarController?._dismiss != null) {
      await snackbarController!.dismiss(animate: animate);
      return;
    }

    entry.remove();
    _clearCurrentIf(entry);
  }

  static void _clearCurrentIf(OverlayEntry entry) {
    if (_currentEntry == entry) {
      _currentEntry = null;
      _currentSnackbarController = null;
    }
  }

  static Widget _defaultContent(String text) {
    return _MPSnackBarContainer(
      backgroundColor: ColorStyles.gray80,
      boxShadow: [
        BoxShadow(
          blurRadius: 10.r,
          color: Color(0x290B0C0C),
          offset: Offset(0, 4.h),
        ),
      ],
      child: Text(
        text,
        textAlign: .center,
        style: Pretendard.medium.set(
          size: 16,
          height: 1.45,
          letterSpacing: -0.1088,
          color: ColorStyles.white,
        ),
      ),
    );
  }
}

class _MPSnackBarContainer extends StatelessWidget {
  final Color backgroundColor;
  final List<BoxShadow>? boxShadow;
  final Widget child;

  const _MPSnackBarContainer({
    required this.backgroundColor,
    this.boxShadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: .symmetric(horizontal: 24.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: .circular(999.r),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}

class _MPSnackbarOverlayView extends StatelessWidget {
  final MPSnackbarController snackbarController;
  final Duration duration;
  final Widget content;
  final VoidCallback onClosed;
  final double bottomMargin;
  final double leftMargin;
  final double rightMargin;

  const _MPSnackbarOverlayView({
    required this.snackbarController,
    required this.duration,
    required this.content,
    required this.onClosed,
    required this.bottomMargin,
    required this.leftMargin,
    required this.rightMargin,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bottomPadding = mediaQuery.padding.bottom;
    final keyboardHeight = mediaQuery.viewInsets.bottom;

    return IgnorePointer(
      ignoring: true,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: leftMargin,
            right: rightMargin,
            bottom: bottomPadding + bottomMargin + keyboardHeight,
            child: IgnorePointer(
              ignoring: false,
              child: MPSnackbar(
                controller: snackbarController,
                duration: duration,
                onDismissed: onClosed,
                content: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
