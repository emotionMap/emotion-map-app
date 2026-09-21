import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/module/location/widget/sido_sigungu_picker.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 가입 시 위치 설정 - 지금은 이게 유일한 가입 절차다 (닉네임/사진 등 프로필 없음).
@RoutePage()
class LocationSetupView extends HookConsumerWidget {
  const LocationSetupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationService = ref.read(locationServiceProvider);
    final selectedLocationId = useState<int?>(null);

    Future<void> onConfirm() async {
      final locationId = selectedLocationId.value;
      if (locationId == null) return;

      context.loaderOverlay.show();
      try {
        await locationService.setLocation(locationId);
        if (!context.mounted) return;
        context.router.replace(const MainTabsRoute());
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('위치 설정에 실패했어요. 다시 시도해 주세요.')),
          );
        }
      } finally {
        if (context.mounted) context.loaderOverlay.hide();
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('위치 설정')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              Text(
                '활동할 지역을 선택해 주세요',
                style: NotoSansKR.bold.set(size: 17, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                '가입을 위한 마지막 한 단계예요.',
                style: NotoSansKR.regular.set(
                  size: 13,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SiDoSiGunGuPicker(
                  onPicked: (locationId, _) =>
                      selectedLocationId.value = locationId,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: selectedLocationId.value == null
                      ? null
                      : onConfirm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.accent.withValues(
                      alpha: 0.35,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    '완료',
                    style: NotoSansKR.semiBold.set(size: 16, fixedHeight: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
