import 'package:flutter/material.dart';

/// 지도 화면 전용 테마 - 앱의 나머지 화면(테라코타/크림)은 그대로 두고
/// 이 화면 안에서만 고정 시간(06~18시) 기준으로 낮/밤 배경과 장식을 바꾼다.
class MapTheme {
  final List<Color> backgroundGradient;
  final Color cardColor;
  final Color cardBorder;
  final Color accentIconColor;
  final IconData motifIcon;
  final Color textColor;
  final Color mutedTextColor;
  final bool isNight;

  const MapTheme({
    required this.backgroundGradient,
    required this.cardColor,
    required this.cardBorder,
    required this.accentIconColor,
    required this.motifIcon,
    required this.textColor,
    required this.mutedTextColor,
    required this.isNight,
  });

  static const day = MapTheme(
    // 밤(짙은 남색 하늘 + 별)과 같은 "하늘" 컨셉 - 위(천정)는 짙은 하늘색,
    // 아래(지평선)는 뿌옇게 옅어지는 하늘색 톤만으로 구성한다.
    // 채도를 낮춘 파스텔이면 흐린 날처럼 보여서, 맑은 날 느낌이 나도록
    // 더 선명하고 채도 높은 파랑을 썼다.
    backgroundGradient: [Color(0xFF3FA9E0), Color(0xFFBFE7F7)],
    cardColor: Colors.white,
    cardBorder: Color(0x33C97B5A),
    accentIconColor: Color(0xFFE8A33D),
    motifIcon: Icons.wb_sunny_rounded,
    textColor: Color(0xFF4A3B33),
    mutedTextColor: Color(0xFF8A7A6E),
    isNight: false,
  );

  static const night = MapTheme(
    backgroundGradient: [Color(0xFF14162B), Color(0xFF2C2A55)],
    cardColor: Color(0xFF23234A),
    cardBorder: Color(0x33FFFFFF),
    accentIconColor: Color(0xFFF3E9C9),
    motifIcon: Icons.nights_stay_rounded,
    textColor: Color(0xFFF3EFE6),
    mutedTextColor: Color(0xFFB4AFD0),
    isNight: true,
  );

  static MapTheme current() {
    final hour = DateTime.now().hour;
    return (hour >= 6 && hour < 18) ? day : night;
  }
}
