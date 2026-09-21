import 'package:emotion_map_app/generate/model/post_list_response.dart';
import 'package:emotion_map_app/module/feed/widget/emotion_chip_row.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/time_format.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final PostListResponse post;
  final VoidCallback onTap;
  final VoidCallback onLikeTap;

  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLikeTap,
  });

  @override
  Widget build(BuildContext context) {
    final images = post.imageList ?? [];
    final liked = post.likeYN == 'Y';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppDecorations.card(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  post.nickname ?? '익명',
                  style: NotoSansKR.semiBold.set(
                    size: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                const EMWidth(6),
                Text(
                  '·',
                  style: NotoSansKR.regular.set(
                    size: 13,
                    color: AppColors.textMuted,
                  ),
                ),
                const EMWidth(6),
                Text(
                  absoluteTime(post.createdAt),
                  style: NotoSansKR.regular.set(
                    size: 12,
                    color: AppColors.textMuted,
                  ),
                ),
                const Spacer(),
                if (post.siGunGu != null)
                  Text(
                    post.siGunGu!,
                    style: NotoSansKR.medium.set(
                      size: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
            const EMHeight(10),
            if ((post.emotionList ?? []).isNotEmpty) ...[
              EmotionChipRow(
                emotions: post.emotionList!,
                showName: true,
                emojiSize: 16,
              ),
              const EMHeight(8),
            ],
            if ((post.content ?? '').isNotEmpty)
              Text(
                post.content!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: NotoSansKR.regular.set(
                  size: 14,
                  fixedHeight: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            if (images.isNotEmpty) ...[
              const EMHeight(10),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: EMNetworkImage(
                  images.first.url ?? '',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ],
            const EMHeight(12),
            Row(
              children: [
                InkWell(
                  onTap: onLikeTap,
                  borderRadius: BorderRadius.circular(999),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          liked ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: liked
                              ? AppColors.accent
                              : AppColors.textMuted,
                        ),
                        const EMWidth(4),
                        Text(
                          '${post.likeCount ?? 0}',
                          style: NotoSansKR.medium.set(
                            size: 13,
                            color: liked
                                ? AppColors.accent
                                : AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const EMWidth(16),
                Icon(
                  Icons.mode_comment_outlined,
                  size: 17,
                  color: AppColors.textMuted,
                ),
                const EMWidth(4),
                Text(
                  '${post.commentCount ?? 0}',
                  style: NotoSansKR.medium.set(
                    size: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
