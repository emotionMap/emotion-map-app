part of 'index.dart';

/// 브랜드 컬러 - "웜 뉴트럴" (거의 흑백, 감정 이모지·지도 색이 도드라지도록)
class AppColors {
  AppColors._();

  /// 이전 테라코타 & 크림(2026-09-13~14)에서 전환 (2026-09-15) - 감정 태그·지도가
  /// 색을 충분히 담당하니 앱 기본톤은 절제하기로 결정. 순수 흑백 대신 아주 옅은
  /// 웜톤을 남겨 차갑게 느껴지지 않게 했다 (3안 중 사용자가 고른 방향 A).
  static const background = Color(0xFFFAF8F6);
  static const surface = Color(0xFFFFFFFF);
  static const textPrimary = Color(0xFF242019);
  static const textMuted = Color(0xFF9C948C);
  static const accent = Color(0xFF242019);
  static const accentDark = Color(0xFF242019);
  static const error = Color(0xFFB3453A);

  /// 콘텐츠 카드/입력창/하단탭 등 "표면"이 배경과 구분되도록 쓰는 공용 경계선 색.
  /// 화면마다 다른 투명도 값을 하드코딩하지 않고 이 토큰 하나로 통일한다.
  static Color get border => accent.withValues(alpha: 0.13);
}
