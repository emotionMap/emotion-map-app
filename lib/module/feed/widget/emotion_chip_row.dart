import 'package:emotion_map_app/generate/model/emotion.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';

/// 게시글/지역 카드 공용 - 감정 이모지(+선택적 이름) 나열.
/// 감정을 드러내는 게 이 앱의 핵심이라 줄이거나 '...'으로 생략하지 않는다 -
/// 한 줄로 배치하고, 다 안 들어가면 좌우로 드래그해서 전부 볼 수 있게 한다.
class EmotionChipRow extends StatelessWidget {
  final List<Emotion> emotions;
  final bool showName;
  final double emojiSize;

  const EmotionChipRow({
    super.key,
    required this.emotions,
    this.showName = false,
    this.emojiSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    if (emotions.isEmpty) return const SizedBox.shrink();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (var i = 0; i < emotions.length; i++) ...[
            if (i > 0) const EMWidth(6),
            _EmotionChip(
              emotion: emotions[i],
              showName: showName,
              emojiSize: emojiSize,
            ),
          ],
        ],
      ),
    );
  }
}

class _EmotionChip extends StatelessWidget {
  final Emotion emotion;
  final bool showName;
  final double emojiSize;

  const _EmotionChip({
    required this.emotion,
    required this.showName,
    required this.emojiSize,
  });

  @override
  Widget build(BuildContext context) {
    final emoji = emotion.emoji ?? '';
    final name = emotion.name ?? '';

    if (!showName) {
      return Text(emoji, style: TextStyle(fontSize: emojiSize));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: emojiSize)),
          const EMWidth(4),
          Text(
            name,
            style: NotoSansKR.medium.set(
              size: 12,
              color: AppColors.accentDark,
            ),
          ),
        ],
      ),
    );
  }
}
