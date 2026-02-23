import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/asset/index.dart';
import 'package:emotion_map_app/module/onboard/onboard_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class OnboardView extends HookConsumerWidget {
  const OnboardView({super.key});

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
              "지금 3초면 충분해요",
              textAlign: .center,
              style: NotoSansKR.bold.set(
                size: 18,
                fixedHeight: 18,
                color: Color(0xFF121212),
              ),
            ),
            EMHeight(8),
            Text(
              "가입하고 당신의 감정을 공유하세요 ❤",
              textAlign: .center,
              style: NotoSansKR.regular.set(
                size: 12,
                fixedHeight: 14,
                color: Color(0xFF474747),
              ),
            ),
            EMHeight(19),
            Expanded(
              child: Column(
                spacing: 18,
                mainAxisAlignment: .center,
                crossAxisAlignment: .stretch,
                children: [
                  (
                    WebpImage.socialKakao,
                    "카카오 로그인",
                    Color(0xFFFEE500),
                    Color(0xFF121212),
                    () => onLogin(ref, .kakao),
                  ),
                  (
                    WebpImage.socialNaver,
                    "네이버 로그인",
                    Color(0xFF03C75A),
                    Colors.white,
                    () => onLogin(ref, .naver),
                  ),
                  (
                    WebpImage.socialApple,
                    "애플 로그인",
                    Color(0xFF050708),
                    Colors.white,
                    () {},
                  ),
                ].map((item) => OnboardButton(item: item)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardButton extends StatelessWidget {
  final (String, String, Color, Color, void Function()) item;

  const OnboardButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: item.$5,
      child: Container(
        height: 45,
        decoration: BoxDecoration(borderRadius: .circular(6), color: item.$3),
        child: Row(
          mainAxisAlignment: .center,
          spacing: 18,
          children: [
            EMImage(item.$1, size: 18),
            Text(
              item.$2,
              style: NotoSansKR.regular.set(
                size: 14,
                fixedHeight: 18,
                letterSpacing: 1,
                color: item.$4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
