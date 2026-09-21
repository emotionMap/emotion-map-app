import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/sigungu_response.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 시/도 선택 -> 시/군/구 선택 2단 리스트. 가입 시 위치 설정 화면과
/// 글쓰기 화면(바텀시트)에서 공용으로 쓴다.
class SiDoSiGunGuPicker extends HookConsumerWidget {
  final void Function(int locationId, String label) onPicked;

  const SiDoSiGunGuPicker({super.key, required this.onPicked});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationService = ref.read(locationServiceProvider);

    final sidoFuture = useMemoized(() => locationService.getSidoList());
    final sidoSnapshot = useFuture(sidoFuture);

    final selectedSiDo = useState<String?>(null);
    final sigunguList = useState<List<SigunguResponse>>([]);
    final selectedLocationId = useState<int?>(null);
    final loadingSigungu = useState(false);

    Future<void> onSelectSiDo(String siDo) async {
      selectedSiDo.value = siDo;
      selectedLocationId.value = null;
      sigunguList.value = [];
      loadingSigungu.value = true;
      try {
        final list = await locationService.getSigunguList(siDo);
        sigunguList.value = list;
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('지역 목록을 불러오지 못했어요.')),
          );
        }
      } finally {
        loadingSigungu.value = false;
      }
    }

    void onSelectSigungu(SigunguResponse sigungu) {
      final locationId = sigungu.locationId;
      if (locationId == null) return;
      selectedLocationId.value = locationId;
      onPicked(locationId, '${selectedSiDo.value ?? ''} ${sigungu.siGunGu ?? ''}'.trim());
    }

    if (sidoSnapshot.connectionState != ConnectionState.done) {
      return const Center(child: CircularProgressIndicator());
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView(
            children: (sidoSnapshot.data ?? [])
                .map(
                  (siDo) => _OptionTile(
                    label: siDo,
                    selected: siDo == selectedSiDo.value,
                    onTap: () => onSelectSiDo(siDo),
                  ),
                )
                .toList(),
          ),
        ),
        const VerticalDivider(width: 1),
        Expanded(
          child: loadingSigungu.value
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: sigunguList.value
                      .map(
                        (sigungu) => _OptionTile(
                          label: sigungu.siGunGu ?? '',
                          selected:
                              sigungu.locationId == selectedLocationId.value,
                          onTap: () => onSelectSigungu(sigungu),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        label,
        style: NotoSansKR.medium.set(
          size: 14,
          color: selected ? AppColors.accent : AppColors.textPrimary,
        ),
      ),
      selected: selected,
      selectedTileColor: AppColors.accent.withValues(alpha: 0.08),
      onTap: onTap,
    );
  }
}
