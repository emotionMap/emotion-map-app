part of 'index.dart';

/// 간격 스케일 - 4pt 배수만 허용한다. 임의값(6, 10, 14 등) 대신 이 상수를 참조할 것.
/// [EMHeight]/[EMWidth]가 4의 배수가 아닌 값을 받으면 디버그 빌드에서 assert로 바로 걸린다.
class AppSpacing {
  AppSpacing._();

  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 12.0;
  static const base = 16.0;
  static const lg = 20.0;
  static const xl = 24.0;
  static const xxl = 28.0;
  static const xxxl = 32.0;
}
