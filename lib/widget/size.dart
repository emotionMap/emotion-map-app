part of 'index.dart';

class EMHeight extends SizedBox {
  const EMHeight(double height, {super.key})
    : assert(height % 4 == 0, '간격은 4pt 배수만 허용 (AppSpacing 참고)'),
      super(height: height);
}

class EMWidth extends SizedBox {
  const EMWidth(double width, {super.key})
    : assert(width % 4 == 0, '간격은 4pt 배수만 허용 (AppSpacing 참고)'),
      super(width: width);
}
