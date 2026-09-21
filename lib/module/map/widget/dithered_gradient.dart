import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// 위아래로 색이 아주 조금씩만 바뀌는 넓은 그라데이션(지도 배경)을 그냥
/// LinearGradient로 그리면 8비트 색상 단계가 눈에 띄는 줄무늬(밴딩)로 드러난다.
///
/// 예전엔 그라데이션의 중간 색상 스톱 값 자체를 살짝 흔드는 방식으로 시도했는데,
/// Skia가 스톱 사이를 결국 다시 매끄럽게 보간해서 그리다 보니 밴딩이 그대로
/// 남아있었다(경계 위치만 바뀜). 진짜 해결책은 렌더링된 그라데이션 위에 아주
/// 옅은 노이즈(그레인)를 픽셀 단위로 얹어서 8비트 경계를 깨뜨리는 것 - 눈에는
/// 거의 안 보이지만 단계가 뭉개져서 줄무늬로 안 보인다. Flutter/Skia에 그라데이션
/// dithering을 켜는 공개 API가 없어서 이 방식을 쓴다.
class DitheredGradientBackground extends StatefulWidget {
  final List<Color> colors;

  const DitheredGradientBackground({super.key, required this.colors});

  @override
  State<DitheredGradientBackground> createState() =>
      _DitheredGradientBackgroundState();
}

class _DitheredGradientBackgroundState
    extends State<DitheredGradientBackground> {
  static const _tileSize = 64;
  ui.Image? _noise;

  @override
  void initState() {
    super.initState();
    _buildNoise();
  }

  Future<void> _buildNoise() async {
    final random = Random(7);
    final pixels = Uint8List(_tileSize * _tileSize * 4);
    for (var i = 0; i < _tileSize * _tileSize; i++) {
      final v = random.nextInt(256);
      pixels[i * 4] = v;
      pixels[i * 4 + 1] = v;
      pixels[i * 4 + 2] = v;
      pixels[i * 4 + 3] = 255;
    }
    final completer = Completer<ui.Image>();
    ui.decodeImageFromPixels(
      pixels,
      _tileSize,
      _tileSize,
      ui.PixelFormat.rgba8888,
      completer.complete,
    );
    final image = await completer.future;
    if (mounted) setState(() => _noise = image);
  }

  @override
  void dispose() {
    _noise?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noise = _noise;
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: widget.colors,
              ),
            ),
          ),
          if (noise != null)
            Opacity(
              opacity: 0.045,
              child: RawImage(
                image: noise,
                repeat: ImageRepeat.repeat,
                filterQuality: FilterQuality.none,
              ),
            ),
        ],
      ),
    );
  }
}
