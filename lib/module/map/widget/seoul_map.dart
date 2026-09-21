import 'dart:math' as math;

import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/generate/model/map_region_response.dart';
import 'package:emotion_map_app/module/map/data/seoul_districts.dart';
import 'package:emotion_map_app/module/map/map_theme.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';

/// 서울 25개 구를 실제 경계 모양 그대로 그려서 탭할 수 있는 지도.
/// 구 경계 좌표는 lib/module/map/data/seoul_districts.dart (공공 경계 데이터를
/// 평면 좌표로 변환한 값) 참고 - 손으로 그린 근사 모양이 아니라 실제 행정구역 모양이다.
///
/// 화면 비율과 지도 비율이 달라서(서울은 가로로 넓음) 화면에 통째로 욱여넣으면
/// 위아래 여백만 커지고 지도 자체는 작아진다. 대신 가로/세로 중 더 큰 배율로
/// 꽉 채우고(cover), 잘려나간 가장자리는 InteractiveViewer로 드래그/핀치줌해서
/// 보게 한다 - 네이버/구글 지도가 항상 화면을 꽉 채우는 것과 같은 방식.
class SeoulMap extends StatefulWidget {
  final List<MapRegionResponse> regions;
  final MapTheme theme;

  const SeoulMap({super.key, required this.regions, required this.theme});

  @override
  State<SeoulMap> createState() => _SeoulMapState();
}

class _SeoulMapState extends State<SeoulMap> {
  final _controller = TransformationController();
  bool _centered = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  MapRegionResponse? _dataFor(String districtName) {
    for (final region in widget.regions) {
      final name = region.siGunGu;
      if (name != null && name.contains(districtName)) return region;
    }
    return null;
  }

  void _onDistrictTap(BuildContext context, SeoulDistrict district) {
    final data = _dataFor(district.name);
    final locationId = data?.locationId;
    if (locationId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${district.name}엔 아직 등록된 감정이 없어요')),
      );
      return;
    }
    context.router.push(
      RegionFeedRoute(locationId: locationId, title: district.name),
    );
  }

  void _centerOnce(Size viewport, double mapWidth, double mapHeight) {
    if (_centered) return;
    _centered = true;
    final dx = (mapWidth - viewport.width) / 2;
    final dy = (mapHeight - viewport.height) / 2;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.value = Matrix4.translationValues(-dx, -dy, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final viewport = Size(constraints.maxWidth, constraints.maxHeight);
          final coverScale = math.max(
            viewport.width / seoulMapNaturalWidth,
            viewport.height / seoulMapNaturalHeight,
          );
          // 화면을 꽉 채우는 배율(coverScale)보다 기본적으로 더 확대해서 보여준다.
          // InteractiveViewer의 minScale을 1/_initialZoom으로 잡아, 핀치로 축소하면
          // 정확히 coverScale(도시 전체가 보이는 지점)까지는 되돌아갈 수 있게 한다.
          const initialZoom = 1.5;
          final scale = coverScale * initialZoom;
          final mapWidth = seoulMapNaturalWidth * scale;
          final mapHeight = seoulMapNaturalHeight * scale;
          _centerOnce(viewport, mapWidth, mapHeight);

          return InteractiveViewer(
            transformationController: _controller,
            constrained: false,
            boundaryMargin: EdgeInsets.zero,
            minScale: 1 / initialZoom,
            maxScale: 4,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (details) {
                final local = details.localPosition / scale;
                for (final district in seoulDistricts) {
                  if (_polygonContains(district.points, local)) {
                    _onDistrictTap(context, district);
                    break;
                  }
                }
              },
              child: CustomPaint(
                size: Size(mapWidth, mapHeight),
                painter: _SeoulMapPainter(theme: widget.theme, dataFor: _dataFor),
              ),
            ),
          );
        },
      ),
    );
  }
}

bool _polygonContains(List<Offset> points, Offset p) {
  var inside = false;
  for (var i = 0, j = points.length - 1; i < points.length; j = i++) {
    final pi = points[i];
    final pj = points[j];
    final crosses = (pi.dy > p.dy) != (pj.dy > p.dy);
    if (crosses &&
        p.dx < (pj.dx - pi.dx) * (p.dy - pi.dy) / (pj.dy - pi.dy) + pi.dx) {
      inside = !inside;
    }
  }
  return inside;
}

double _distanceToSegment(Offset p, Offset a, Offset b) {
  final abx = b.dx - a.dx;
  final aby = b.dy - a.dy;
  final lenSq = abx * abx + aby * aby;
  var t = lenSq == 0 ? 0.0 : ((p.dx - a.dx) * abx + (p.dy - a.dy) * aby) / lenSq;
  t = t.clamp(0.0, 1.0);
  final closest = Offset(a.dx + t * abx, a.dy + t * aby);
  return (p - closest).distance;
}

double _distanceToBoundary(List<Offset> points, Offset p) {
  var minDist = double.infinity;
  for (var i = 0, j = points.length - 1; i < points.length; j = i++) {
    final d = _distanceToSegment(p, points[j], points[i]);
    if (d < minDist) minDist = d;
  }
  return minDist;
}

/// 구 라벨을 놓기 좋은 지점(경계선에서 가장 먼 안쪽 지점)을 2단계 격자
/// 탐색으로 찾는다. 꼭짓점 평균(centroid)은 오목한 모양에서 경계선에 바짝
/// 붙거나 폴리곤 밖으로 나가기도 해서 라벨 위치로는 부적합하다 - 지도 라이브러리들이
/// 라벨 배치에 흔히 쓰는 polylabel 알고리즘을 단순화한 버전.
///
/// 구는 25개뿐이고 이 계산은 구마다 한 번만(첫 페인트 때) 실행돼서(아래 캐시),
/// 매 프레임 반복되지 않는다 - InteractiveViewer의 팬/줌은 이미 그려진 레이어를
/// 이동/확대할 뿐 paint()를 다시 부르지 않는다.
Offset _computeVisualCenter(List<Offset> points) {
  var minX = points.first.dx, maxX = points.first.dx;
  var minY = points.first.dy, maxY = points.first.dy;
  for (final p in points) {
    if (p.dx < minX) minX = p.dx;
    if (p.dx > maxX) maxX = p.dx;
    if (p.dy < minY) minY = p.dy;
    if (p.dy > maxY) maxY = p.dy;
  }

  var best = Offset((minX + maxX) / 2, (minY + maxY) / 2);
  var bestDist = -1.0;

  void search(double x0, double x1, double y0, double y1, int steps) {
    final stepX = (x1 - x0) / steps;
    final stepY = (y1 - y0) / steps;
    for (var i = 0; i <= steps; i++) {
      for (var j = 0; j <= steps; j++) {
        final p = Offset(x0 + stepX * i, y0 + stepY * j);
        if (!_polygonContains(points, p)) continue;
        final d = _distanceToBoundary(points, p);
        if (d > bestDist) {
          bestDist = d;
          best = p;
        }
      }
    }
  }

  // 1차: 전체 영역을 성긴 격자로 훑는다.
  search(minX, maxX, minY, maxY, 24);
  // 2차: 1차에서 찾은 지점 주변을 촘촘하게 재탐색해 정밀도를 높인다.
  final span = math.max(maxX - minX, maxY - minY) / 24;
  search(best.dx - span, best.dx + span, best.dy - span, best.dy + span, 16);

  return best;
}

final _visualCenterCache = <String, Offset>{};

Offset _labelAnchorFor(SeoulDistrict district) => _visualCenterCache
    .putIfAbsent(district.name, () => _computeVisualCenter(district.points));

class _SeoulMapPainter extends CustomPainter {
  final MapTheme theme;
  final MapRegionResponse? Function(String) dataFor;

  _SeoulMapPainter({required this.theme, required this.dataFor});

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / seoulMapNaturalWidth;
    canvas.save();
    canvas.scale(scale);

    for (final district in seoulDistricts) {
      final data = dataFor(district.name);
      final emotions = data?.recentEmotions ?? const [];
      final hasData = emotions.isNotEmpty;

      final path = Path()..addPolygon(district.points, true);

      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.fill
          ..color = hasData
              ? theme.cardColor
              : theme.cardColor.withValues(alpha: 0.38),
      );
      canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = hasData ? 1.6 : 1.0
          ..color = hasData ? theme.accentIconColor : theme.cardBorder,
      );

      final center = _labelAnchorFor(district);
      final nameStyle = NotoSansKR.medium.set(
        size: 11,
        color: hasData ? theme.textColor : theme.mutedTextColor,
      );
      final nameTp = TextPainter(
        text: TextSpan(text: district.name, style: nameStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      if (hasData) {
        // 최근 감정 상위 3개까지 이모지를 한 줄로 나열한다 (5개는 구 모양이
        // 작아서 글자/이모지가 겹치고 지저분해짐 - 3개가 한계).
        const emojiGap = 1.0;
        final emojiTps = emotions
            .take(3)
            .map(
              (e) => TextPainter(
                text: TextSpan(
                  text: e.emoji ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
                textDirection: TextDirection.ltr,
              )..layout(),
            )
            .toList();
        final emojiRowWidth =
            emojiTps.fold(0.0, (sum, tp) => sum + tp.width) +
            emojiGap * (emojiTps.length - 1);
        final emojiRowHeight = emojiTps
            .map((tp) => tp.height)
            .reduce(math.max);

        const gap = 2.0;
        final totalHeight = emojiRowHeight + gap + nameTp.height;
        final top = center.dy - totalHeight / 2;

        var emojiX = center.dx - emojiRowWidth / 2;
        for (final tp in emojiTps) {
          tp.paint(canvas, Offset(emojiX, top));
          emojiX += tp.width + emojiGap;
        }
        nameTp.paint(
          canvas,
          Offset(center.dx - nameTp.width / 2, top + emojiRowHeight + gap),
        );
      } else {
        nameTp.paint(
          canvas,
          Offset(center.dx - nameTp.width / 2, center.dy - nameTp.height / 2),
        );
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _SeoulMapPainter oldDelegate) =>
      oldDelegate.theme != theme || oldDelegate.dataFor != dataFor;
}
