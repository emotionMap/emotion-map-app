import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/asset/index.dart';
import 'package:emotion_map_app/module/onboard/onboard_provider.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class OnboardView extends HookConsumerWidget {
  const OnboardView({super.key});

  Future<void> _onStart(BuildContext context, WidgetRef ref) async {
    try {
      final locationSet = await startAnonymousLogin(ref);
      if (!context.mounted) return;

      if (locationSet) {
        context.router.replace(const MainTabsRoute());
      } else {
        context.router.replace(const LocationSetupRoute());
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('로그인에 실패했어요. 다시 시도해 주세요.')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: .symmetric(horizontal: 16),
        child: EMSafeColumn(
          top: true,
          bottom: true,
          crossAxisAlignment: .stretch,
          children: [
            EMHeight(84),
            Center(
              child: EMImage(WebpImage.onbaordLogo, width: 194, fit: .fitWidth),
            ),
            EMHeight(20),
            Text(
              "3초면 충분해요",
              textAlign: .center,
              style: NotoSansKR.bold.set(
                size: 18,
                fixedHeight: 18,
                color: AppColors.textPrimary,
              ),
            ),
            EMHeight(8),
            Text(
              "지금 느끼는 감정을 자유롭게 남겨보세요.",
              textAlign: .center,
              style: NotoSansKR.regular.set(
                size: 12,
                fixedHeight: 16,
                color: AppColors.textMuted,
              ),
            ),
            Spacer(),
            SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: () => _onStart(context, ref),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  "시작하기",
                  style: NotoSansKR.semiBold.set(size: 16, fixedHeight: 16),
                ),
              ),
            ),
            EMHeight(24),
          ],
        ),
      ),
    );
  }
}
