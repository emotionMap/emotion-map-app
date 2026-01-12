part of 'index.dart';

class EMSingleScroll extends SingleChildScrollView {
  const EMSingleScroll({
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

class EMNestedScroll extends NestedScrollView {
  const EMNestedScroll({
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

class EMCustomScroll extends CustomScrollView {
  const EMCustomScroll({
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
