import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/map_region_response.dart';
import 'package:emotion_map_app/module/main_tabs/tab_index.dart';
import 'package:emotion_map_app/module/map/map_theme.dart';
import 'package:emotion_map_app/module/map/widget/cloud_field.dart';
import 'package:emotion_map_app/module/map/widget/dithered_gradient.dart';
import 'package:emotion_map_app/module/map/widget/seoul_map.dart';
import 'package:emotion_map_app/module/map/widget/star_field.dart';
import 'package:emotion_map_app/module/map/widget/sun_glow.dart';
import 'package:emotion_map_app/util/tab_reentry.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 지도 탭에 재진입할 때마다 화면이 새로 마운트되도록, 실제 내용은
/// [_MapBody]에 두고 이 위젯은 재진입 키만 관리한다.
@RoutePage()
class MapView extends HookWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    final reentryKey = useTabReentryKey(context, kMapTabIndex);
    return _MapBody(key: ValueKey(reentryKey));
  }
}

class _MapBody extends HookConsumerWidget {
  const _MapBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapService = ref.read(mapServiceProvider);
    // TODO: 테스트 빌드에서 낮/밤 디자인을 바로 비교해보기 위한 임시 토글.
    // 실제 시간 기반 전환(MapTheme.current())은 초기값으로만 쓰고,
    // 정식 배포 전에는 이 토글 버튼과 isNight 상태를 제거하고 다시
    // useMemoized(MapTheme.current)로 되돌린다.
    final isNight = useState(MapTheme.current().isNight);
    final theme = isNight.value ? MapTheme.night : MapTheme.day;

    final regions = useState<List<MapRegionResponse>>([]);
    final loading = useState(true);

    Future<void> fetch() async {
      loading.value = true;
      try {
        regions.value = await mapService.getRegionSummaries();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('지도를 불러오지 못했어요.')));
        }
      } finally {
        loading.value = false;
      }
    }

    useEffect(() {
      fetch();
      return null;
      // ignore: exhaustive_keys
    }, const []);

    return Scaffold(
      body: Stack(
        children: [
          DitheredGradientBackground(colors: theme.backgroundGradient),
          if (theme.isNight)
            const Positioned.fill(child: StarField())
          else ...[
            const SunGlow(),
            const Positioned.fill(child: CloudField()),
          ],
          SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: kToolbarHeight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          EMTopBarTitle(
                            title: '감정 지도',
                            color: theme.textColor,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => isNight.value = !isNight.value,
                            tooltip: '낮/밤 미리보기 (테스트용)',
                            icon: Icon(
                              isNight.value
                                  ? Icons.wb_sunny_rounded
                                  : Icons.nights_stay_rounded,
                              color: theme.textColor,
                            ),
                          ),
                          IconButton(
                            onPressed: loading.value ? null : fetch,
                            icon: Icon(
                              Icons.refresh_rounded,
                              color: theme.textColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: loading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: theme.accentIconColor,
                            ),
                          )
                        : SeoulMap(regions: regions.value, theme: theme),
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }
}

