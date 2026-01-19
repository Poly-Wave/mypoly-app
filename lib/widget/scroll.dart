part of 'index.dart';

class MPSingleScroll extends SingleChildScrollView {
  const MPSingleScroll({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.padding,
    super.primary,
    super.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    super.controller,
    super.child,
    super.dragStartBehavior,
    super.clipBehavior,
    super.restorationId,
    super.keyboardDismissBehavior,
  });
}

class MPNestedScroll extends NestedScrollView {
  const MPNestedScroll({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    required super.headerSliverBuilder,
    required super.body,
    super.floatHeaderSlivers,
    super.scrollBehavior,
    super.dragStartBehavior,
    super.restorationId,
    super.clipBehavior,
  });
}

class MPCustomScroll extends CustomScrollView {
  const MPCustomScroll({
    super.key,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics = const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    ),
    super.scrollBehavior,
    super.shrinkWrap,
    super.center,
    super.anchor,
    super.cacheExtent,
    super.slivers = const <Widget>[],
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  });
}
