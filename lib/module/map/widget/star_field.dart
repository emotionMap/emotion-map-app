import 'package:flutter/material.dart';

/// 밤 테마 배경 장식용 - 고정된 위치에 작은 점을 흩뿌려 별처럼 보이게 한다.
class StarField extends StatelessWidget {
  const StarField({super.key});

  static const _positions = [
    Offset(0.06, 0.05),
    Offset(0.18, 0.14),
    Offset(0.32, 0.06),
    Offset(0.46, 0.18),
    Offset(0.6, 0.05),
    Offset(0.74, 0.12),
    Offset(0.88, 0.04),
    Offset(0.94, 0.2),
    Offset(0.12, 0.26),
    Offset(0.4, 0.3),
    Offset(0.68, 0.28),
    Offset(0.85, 0.34),
    Offset(0.05, 0.42),
    Offset(0.28, 0.45),
    Offset(0.55, 0.4),
    Offset(0.78, 0.46),
    Offset(0.15, 0.58),
    Offset(0.5, 0.62),
    Offset(0.9, 0.6),
    Offset(0.35, 0.7),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: _positions.map((p) {
            final size = (p.dx * 7).toInt().isEven ? 2.0 : 3.0;
            return Positioned(
              left: p.dx * constraints.maxWidth,
              top: p.dy * constraints.maxHeight,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  shape: BoxShape.circle,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
