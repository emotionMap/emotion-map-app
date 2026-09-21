import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/post.dart';
import 'package:emotion_map_app/module/feed/widget/paginated_posts.dart';
import 'package:emotion_map_app/module/write/widget/post_form.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 내가 쓴 글의 위치/감정/본문을 고치는 화면. [WriteView]와 폼 UI를
/// [PostForm]으로 공유하고, 제출 성공 시 상세 화면으로 되돌아가며 새로고침 신호를 준다.
@RoutePage()
class PostEditView extends HookConsumerWidget {
  final Post post;

  const PostEditView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);
    final postId = post.postId;
    final locationLabel = [
      post.siDo,
      post.siGunGu,
    ].where((e) => (e ?? '').isNotEmpty).join(' ');

    return Scaffold(
      appBar: const EMTopBar(title: '게시글 수정'),
      body: PostForm(
        initialContent: post.content ?? '',
        initialLocationId: post.locationId,
        initialLocationLabel: locationLabel.isEmpty ? null : locationLabel,
        initialEmotionIds: (post.emotionList ?? [])
            .map((e) => e.id)
            .whereType<int>()
            .toSet(),
        submitLabel: '수정 완료',
        onSubmit: ({
          required locationId,
          required locationLabel,
          required emotionIds,
          content,
        }) async {
          if (postId == null) return;
          try {
            await postsService.updatePost(
              postId: postId,
              locationId: locationId,
              emotionIds: emotionIds,
              content: content,
            );
            postsChangedSignal.value++;
            if (!context.mounted) return;
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('게시글이 수정됐어요.')));
            context.router.maybePop(true);
          } catch (_) {
            if (context.mounted) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('게시글 수정에 실패했어요.')));
            }
          }
        },
      ),
    );
  }
}
