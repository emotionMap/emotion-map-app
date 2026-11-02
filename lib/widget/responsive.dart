part of 'index.dart';

/// 폴드폰을 펼쳤을 때/태블릿처럼 shortestSide가 넓은 화면인지 판별한다.
/// 화면 폭이 아니라 shortestSide 기준인 이유: 폴드폰은 펼친 상태에서 가로/세로
/// 회전도 자유로워서, 폭만 보면 세로일 때와 가로일 때 결과가 뒤집힌다.
extension EMResponsiveContext on BuildContext {
  bool get isWideScreen =>
      MediaQuery.sizeOf(this).shortestSide >= AppBreakpoints.wide;
}
