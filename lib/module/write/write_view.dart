import 'package:auto_route/auto_route.dart';
import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/module/main_tabs/tab_index.dart';
import 'package:emotion_map_app/module/write/widget/post_form.dart';
import 'package:emotion_map_app/provider/app_provider.dart';
import 'package:emotion_map_app/util/tab_reentry.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _lastWriteLocationIdKey = 'last_write_location_id';
const _lastWriteLocationLabelKey = 'last_write_location_label';

/// 글쓰기 탭에 재진입할 때마다 폼이 새로 마운트되도록(이전에 고르던 값이
/// 남지 않도록), 실제 내용은 [_WriteBody]에 두고 이 위젯은 재진입 키만 관리한다.
@RoutePage()
class WriteView extends HookWidget {
  const WriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final reentryKey = useTabReentryKey(context, kWriteTabIndex);
    return _WriteBody(key: ValueKey(reentryKey));
  }
}

class _WriteBody extends HookConsumerWidget {
  const _WriteBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsService = ref.read(postsServiceProvider);
    final localStorage = ref.read(localStorageProvider);

    return Scaffold(
      appBar: const EMTopBar(title: '글쓰기'),
      body: PostForm(
        initialLocationId: localStorage.getInt(_lastWriteLocationIdKey),
        initialLocationLabel: localStorage.getString(
          _lastWriteLocationLabelKey,
        ),
        submitLabel: '작성하기',
        onSubmit:
            ({
              required locationId,
              required locationLabel,
              required emotionIds,
              content,
            }) async {
              try {
                await postsService.createPost(
                  locationId: locationId,
                  emotionIds: emotionIds,
                  content: content,
                );
                await localStorage.setInt(
                  _lastWriteLocationIdKey,
                  locationId,
                );
                await localStorage.setString(
                  _lastWriteLocationLabelKey,
                  locationLabel,
                );
                if (!context.mounted) return;
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('게시글이 등록됐어요.')));
                AutoTabsRouter.of(context).setActiveIndex(0);
              } catch (_) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('게시글 등록에 실패했어요.')),
                  );
                }
              }
            },
      ),
    );
  }
}
