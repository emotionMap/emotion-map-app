part of 'index.dart';

class EMSafeBox extends SafeArea {
  const EMSafeBox({
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

class EMSafeColumn extends Column {
  final bool top;
  final bool bottom;

  EMSafeColumn({
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
           if (top) const EMSafeBox(top: true),
           ...children,
           if (bottom) const EMSafeBox(bottom: true),
         ],
       );
}
