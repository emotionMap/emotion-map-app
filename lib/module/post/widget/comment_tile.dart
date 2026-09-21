import 'package:emotion_map_app/generate/model/comment_response.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/comment_tree.dart';
import 'package:emotion_map_app/util/time_format.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';

/// 댓글 1개 + 대댓글을 재귀적으로 렌더한다.
/// depth는 좌측 들여쓰기에 쓰이며 4단계에서 캡한다 (더 깊어도 화면이 깨지지 않도록).
class CommentTile extends StatelessWidget {
  final CommentResponse comment;
  final int depth;
  final void Function(CommentResponse comment) onReply;

  const CommentTile({
    super.key,
    required this.comment,
    this.depth = 0,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final deleted =
        comment.status == CommentResponseStatusEnum.deleted;
    final children = commentChildren(comment);
    final indent = depth.clamp(0, 4) * 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: indent, top: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.nickname ?? '익명',
                    style: NotoSansKR.semiBold.set(
                      size: 12.5,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const EMWidth(6),
                  Text(
                    relativeTime(comment.createdAt),
                    style: NotoSansKR.regular.set(
                      size: 11,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
              const EMHeight(4),
              Text(
                deleted ? '삭제된 댓글입니다' : (comment.content ?? ''),
                style: NotoSansKR.regular.set(
                  size: 13,
                  fixedHeight: 18,
                  color: deleted ? AppColors.textMuted : AppColors.textPrimary,
                  decoration: deleted ? null : null,
                ).copyWith(
                  fontStyle: deleted ? FontStyle.italic : FontStyle.normal,
                ),
              ),
              if (!deleted) ...[
                const EMHeight(4),
                InkWell(
                  onTap: () => onReply(comment),
                  child: Text(
                    '답글',
                    style: NotoSansKR.medium.set(
                      size: 12,
                      color: AppColors.accentDark,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        for (final child in children)
          CommentTile(comment: child, depth: depth + 1, onReply: onReply),
      ],
    );
  }
}
