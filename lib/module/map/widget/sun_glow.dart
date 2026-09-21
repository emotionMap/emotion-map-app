import 'package:flutter/material.dart';

/// 낮 테마 배경 장식용 - 화면 오른쪽 위 구석에서 은은하게 퍼지는 햇살 글로우.
/// 밤의 별빛(StarField)처럼 화면에 화사함을 더하는 포인트.
class SunGlow extends StatelessWidget {
  const SunGlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -60,
      top: -60,
      child: IgnorePointer(
        child: Container(
          width: 240,
          height: 240,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.55),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
