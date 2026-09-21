import 'package:flutter/material.dart';

/// 낮 테마 배경 장식용 - StarField(밤)와 같은 방식으로, 고정된 위치에
/// 뭉게구름 몇 개를 흩뿌려 놓는다. 원 몇 개를 겹쳐서 구름 실루엣을 만든다.
class CloudField extends StatelessWidget {
  const CloudField({super.key});

  // y는 상단탭(제목/토글/새로고침) 영역과 겹치지 않도록 0.1 이후로만 둔다.
  static const _clouds = [
    _CloudSpec(anchor: Offset(0.1, 0.12), scale: 1.0),
    _CloudSpec(anchor: Offset(0.6, 0.1), scale: 0.7),
    _CloudSpec(anchor: Offset(0.8, 0.2), scale: 0.5),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: _clouds
              .map((spec) => _Cloud(spec: spec, canvasSize: constraints.biggest))
              .toList(),
        );
      },
    );
  }
}

class _CloudSpec {
  final Offset anchor;
  final double scale;

  const _CloudSpec({required this.anchor, required this.scale});
}

class _Cloud extends StatelessWidget {
  final _CloudSpec spec;
  final Size canvasSize;

  const _Cloud({required this.spec, required this.canvasSize});

  @override
  Widget build(BuildContext context) {
    final s = spec.scale;
    return Positioned(
      left: spec.anchor.dx * canvasSize.width,
      top: spec.anchor.dy * canvasSize.height,
      child: SizedBox(
        width: 92 * s,
        height: 40 * s,
        child: Stack(
          children: [
            Positioned(left: 0, top: 12 * s, child: _puff(30 * s)),
            Positioned(left: 18 * s, top: 0, child: _puff(38 * s)),
            Positioned(left: 42 * s, top: 8 * s, child: _puff(34 * s)),
            Positioned(left: 60 * s, top: 14 * s, child: _puff(24 * s)),
          ],
        ),
      ),
    );
  }

  Widget _puff(double diameter) => Container(
    width: diameter,
    height: diameter,
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      shape: BoxShape.circle,
    ),
  );
}
