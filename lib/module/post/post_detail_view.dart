import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/comment_response.dart';
import 'package:emotion_map_app/generate/model/post_detail_response.dart';
import 'package:emotion_map_app/module/feed/widget/emotion_chip_row.dart';
import 'package:emotion_map_app/module/feed/widget/paginated_posts.dart';
import 'package:emotion_map_app/module/post/widget/comment_tile.dart';
import 'package:emotion_map_app/provider/router_provider.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/util/time_format.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class PostDetailView extends HookConsumerWidget {
  final int postId;

  const PostDetailView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);
    final commentsService = ref.read(commentsServiceProvider);

    final detail = useState<PostDetailResponse?>(null);
    final initialLoading = useState(true);
    final replyTarget = useState<CommentResponse?>(null);
    final inputController = useTextEditingController();
    final submitting = useState(false);

    Future<void> fetchDetail() async {
      try {
        final result = await postsService.getPost(postId);
        detail.value = result;
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('게시글을 불러오지 못했어요.')));
        }
      } finally {
        initialLoading.value = false;
      }
    }

    useEffect(() {
      fetchDetail();
      return null;
      // ignore: exhaustive_keys
    }, const []);

    Future<void> onLikeTap() async {
      final post = detail.value?.post;
      if (post == null) return;
      try {
        final result = await postsService.toggleLike(postId);
        final liked = result == 'Y';
        final wasLiked = post.likeYN == 'Y';
        final delta = liked == wasLiked ? 0 : (liked ? 1 : -1);
        detail.value = detail.value?.copyWith(
          post: post.copyWith(
            likeYN: liked ? 'Y' : 'N',
            likeCount: (post.likeCount ?? 0) + delta,
          ),
        );
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('좋아요 처리에 실패했어요.')));
        }
      }
    }

    Future<void> onSubmitComment() async {
      final content = inputController.text.trim();
      if (content.isEmpty || submitting.value) return;

      submitting.value = true;
      try {
        await commentsService.createComment(
          postId,
          content,
          parentCommentId: replyTarget.value?.commentId,
        );
        inputController.clear();
        replyTarget.value = null;
        if (!context.mounted) return;
        FocusScope.of(context).unfocus();
        await fetchDetail();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('댓글 작성에 실패했어요.')));
        }
      } finally {
        submitting.value = false;
      }
    }

    Future<void> onEditTap() async {
      final post = detail.value?.post;
      if (post == null) return;
      final edited = await context.router.push(PostEditRoute(post: post));
      if (edited == true) {
        await fetchDetail();
      }
    }

    Future<void> onDeleteTap() async {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            '게시글을 삭제할까요?',
            style: NotoSansKR.bold.set(size: 16, color: AppColors.textPrimary),
          ),
          content: Text(
            '삭제하면 되돌릴 수 없어요.',
            style: NotoSansKR.regular.set(
              size: 13,
              color: AppColors.textMuted,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                '취소',
                style: NotoSansKR.medium.set(
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                '삭제하기',
                style: NotoSansKR.semiBold.set(size: 14, color: AppColors.error),
              ),
            ),
          ],
        ),
      );
      if (confirmed != true) return;

      try {
        await postsService.deletePost(postId);
        postsChangedSignal.value++;
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('게시글을 삭제했어요.')));
        context.router.maybePop();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('게시글 삭제에 실패했어요.')));
        }
      }
    }

    void openPostMenu() {
      showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (sheetContext) => SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const EMHeight(8),
              ListTile(
                leading: Icon(
                  Icons.edit_outlined,
                  color: AppColors.textPrimary,
                ),
                title: Text(
                  '수정하기',
                  style: NotoSansKR.medium.set(
                    size: 15,
                    color: AppColors.textPrimary,
                  ),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onEditTap();
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_outline, color: AppColors.error),
                title: Text(
                  '삭제하기',
                  style: NotoSansKR.medium.set(size: 15, color: AppColors.error),
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  onDeleteTap();
                },
              ),
            ],
          ),
        ),
      );
    }

    void openImage(String url) {
      showDialog(
        context: context,
        barrierColor: Colors.black,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.zero,
          child: Stack(
            children: [
              Positioned.fill(
                child: InteractiveViewer(
                  child: EMNetworkImage(url, fit: BoxFit.contain),
                ),
              ),
              Positioned(
                top: 40,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final post = detail.value?.post;
    final comments = detail.value?.comments ?? [];

    return Scaffold(
      appBar: const EMTopBar(title: '게시글'),
      body: initialLoading.value
          ? const Center(child: CircularProgressIndicator())
          : post == null
          ? Center(
              child: Text(
                '게시글을 찾을 수 없어요',
                style: NotoSansKR.medium.set(
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: fetchDetail,
                    color: AppColors.accent,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      children: [
                        Row(
                          children: [
                            Text(
                              post.nickname ?? '익명',
                              style: NotoSansKR.semiBold.set(
                                size: 14,
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
                        const EMHeight(14),
                        if ((post.emotionList ?? []).isNotEmpty) ...[
                          EmotionChipRow(
                            emotions: post.emotionList!,
                            showName: true,
                          ),
                          const EMHeight(14),
                        ],
                        if ((post.content ?? '').isNotEmpty)
                          Text(
                            post.content!,
                            style: NotoSansKR.regular.set(
                              size: 15,
                              fixedHeight: 22,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        if ((post.imageList ?? []).isNotEmpty) ...[
                          const EMHeight(14),
                          SizedBox(
                            height: 200,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: post.imageList!.length,
                              separatorBuilder: (_, _) => const EMWidth(8),
                              itemBuilder: (context, index) {
                                final url = post.imageList![index].url ?? '';
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: GestureDetector(
                                    onTap: () => openImage(url),
                                    child: EMNetworkImage(
                                      url,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        const EMHeight(16),
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
                                      post.likeYN == 'Y'
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      size: 18,
                                      color: post.likeYN == 'Y'
                                          ? AppColors.accent
                                          : AppColors.textMuted,
                                    ),
                                    const EMWidth(4),
                                    Text(
                                      '${post.likeCount ?? 0}',
                                      style: NotoSansKR.medium.set(
                                        size: 13,
                                        color: post.likeYN == 'Y'
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
                            if (post.isMine == true) ...[
                              const Spacer(),
                              InkWell(
                                onTap: openPostMenu,
                                borderRadius: BorderRadius.circular(999),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.more_horiz,
                                    size: 20,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const EMHeight(12),
                        Divider(color: AppColors.border),
                        if (comments.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Center(
                              child: Text(
                                '첫 댓글을 남겨보세요',
                                style: NotoSansKR.regular.set(
                                  size: 13,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ),
                          )
                        else
                          for (final comment in comments)
                            CommentTile(
                              comment: comment,
                              onReply: (target) {
                                replyTarget.value = target;
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());
                              },
                            ),
                        const EMHeight(80),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: AppDecorations.elevatedBar(shadow: false),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (replyTarget.value != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              children: [
                                Text(
                                  '${replyTarget.value!.nickname ?? '익명'}님에게 답글 남기는 중',
                                  style: NotoSansKR.medium.set(
                                    size: 12,
                                    color: AppColors.accentDark,
                                  ),
                                ),
                                const EMWidth(6),
                                InkWell(
                                  onTap: () => replyTarget.value = null,
                                  child: Icon(
                                    Icons.close,
                                    size: 14,
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: inputController,
                                minLines: 1,
                                maxLines: 4,
                                style: NotoSansKR.regular.set(
                                  size: 14,
                                  color: AppColors.textPrimary,
                                ),
                                decoration: InputDecoration(
                                  hintText: '댓글을 남겨보세요',
                                  hintStyle: NotoSansKR.regular.set(
                                    size: 14,
                                    color: AppColors.textMuted,
                                  ),
                                  isDense: true,
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 10,
                                  ),
                                ),
                              ),
                            ),
                            const EMWidth(8),
                            IconButton(
                              onPressed: submitting.value
                                  ? null
                                  : onSubmitComment,
                              icon: Icon(
                                Icons.send_rounded,
                                color: AppColors.accent,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
