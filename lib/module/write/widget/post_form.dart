import 'package:emotion_map_app/data/provider/service_provider.dart';
import 'package:emotion_map_app/generate/model/emotion_response.dart';
import 'package:emotion_map_app/module/location/widget/sido_sigungu_picker.dart';
import 'package:emotion_map_app/style/index.dart';
import 'package:emotion_map_app/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

const _maxEmotionCount = 5;

/// 글쓰기/게시글 수정 화면이 공유하는 폼 (위치 선택 + 감정 선택 + 본문 + 제출 버튼).
/// 성공/실패 시 안내와 화면 전환은 화면마다 다르므로 [onSubmit]이 직접 처리하고,
/// 이 위젯은 입력값 수집과 제출 중 로딩 상태만 관리한다.
class PostForm extends HookConsumerWidget {
  final int? initialLocationId;
  final String? initialLocationLabel;
  final Set<int> initialEmotionIds;
  final String initialContent;
  final String contentHint;
  final String submitLabel;
  final Future<void> Function({
    required int locationId,
    required String locationLabel,
    required List<int> emotionIds,
    String? content,
  })
  onSubmit;

  const PostForm({
    super.key,
    this.initialLocationId,
    this.initialLocationLabel,
    this.initialEmotionIds = const {},
    this.initialContent = '',
    this.contentHint = '지금 느끼는 감정을 자유롭게 남겨보세요.(선택)',
    required this.submitLabel,
    required this.onSubmit,
  });

  Future<void> _openLocationPicker(
    BuildContext context,
    ValueNotifier<int?> selectedLocationId,
    ValueNotifier<String?> selectedLocationLabel,
  ) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SizedBox(
        height: MediaQuery.of(sheetContext).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '위치 선택',
                style: NotoSansKR.bold.set(
                  size: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              const EMHeight(12),
              Expanded(
                child: SiDoSiGunGuPicker(
                  onPicked: (locationId, label) {
                    selectedLocationId.value = locationId;
                    selectedLocationLabel.value = label;
                    Navigator.of(sheetContext).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emotionService = ref.read(emotionServiceProvider);

    final emotions = useState<List<EmotionResponse>>([]);
    final emotionsLoading = useState(true);
    final selectedEmotionIds = useState<Set<int>>(initialEmotionIds);
    final selectedLocationId = useState<int?>(initialLocationId);
    final selectedLocationLabel = useState<String?>(initialLocationLabel);
    final contentController = useTextEditingController(text: initialContent);
    final submitting = useState(false);

    Future<void> fetchEmotions() async {
      emotionsLoading.value = true;
      try {
        emotions.value = await emotionService.getEmotions();
      } catch (_) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('감정 목록을 불러오지 못했어요.')));
        }
      } finally {
        emotionsLoading.value = false;
      }
    }

    useEffect(() {
      fetchEmotions();
      return null;
      // ignore: exhaustive_keys
    }, const []);

    void toggleEmotion(int id) {
      final current = {...selectedEmotionIds.value};
      if (current.contains(id)) {
        current.remove(id);
      } else {
        if (current.length >= _maxEmotionCount) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('감정은 최대 5개까지 선택할 수 있어요.')),
          );
          return;
        }
        current.add(id);
      }
      selectedEmotionIds.value = current;
    }

    final canSubmit =
        selectedLocationId.value != null && selectedEmotionIds.value.isNotEmpty;

    Future<void> handleSubmit() async {
      final locationId = selectedLocationId.value;
      final locationLabel = selectedLocationLabel.value;
      if (locationId == null ||
          locationLabel == null ||
          selectedEmotionIds.value.isEmpty ||
          submitting.value) {
        return;
      }

      submitting.value = true;
      try {
        await onSubmit(
          locationId: locationId,
          locationLabel: locationLabel,
          emotionIds: selectedEmotionIds.value.toList(),
          content: contentController.text.trim().isEmpty
              ? null
              : contentController.text.trim(),
        );
      } finally {
        submitting.value = false;
      }
    }

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _openLocationPicker(
              context,
              selectedLocationId,
              selectedLocationLabel,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
              decoration: AppDecorations.card(radius: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.accent,
                  ),
                  const EMWidth(8),
                  Text(
                    selectedLocationLabel.value ?? '위치를 선택해 주세요',
                    style: NotoSansKR.medium.set(
                      size: 14,
                      color: selectedLocationLabel.value == null
                          ? AppColors.textMuted
                          : AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right,
                    size: 18,
                    color: AppColors.textMuted,
                  ),
                ],
              ),
            ),
          ),
          const EMHeight(24),
          emotionsLoading.value
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                )
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 2.2,
                      ),
                  itemCount: emotions.value.length,
                  itemBuilder: (context, index) {
                    final emotion = emotions.value[index];
                    final id = int.tryParse(emotion.id ?? '');
                    if (id == null) return const SizedBox.shrink();
                    final selected = selectedEmotionIds.value.contains(id);
                    final atLimit =
                        !selected &&
                        selectedEmotionIds.value.length >= _maxEmotionCount;
                    return Opacity(
                      opacity: atLimit ? 0.4 : 1,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () => toggleEmotion(id),
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.accent
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.border,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                emotion.emoji ?? '',
                                style: const TextStyle(fontSize: 15),
                              ),
                              const EMWidth(4),
                              Flexible(
                                child: Text(
                                  emotion.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: NotoSansKR.medium.set(
                                    size: 12,
                                    color: selected
                                        ? Colors.white
                                        : AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
          const EMHeight(24),
          TextField(
            controller: contentController,
            minLines: 4,
            maxLines: 8,
            style: NotoSansKR.regular.set(size: 14, color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: contentHint,
              hintStyle: NotoSansKR.regular.set(
                size: 14,
                color: AppColors.textMuted,
              ),
              filled: true,
              fillColor: AppColors.surface,
              contentPadding: const EdgeInsets.all(14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.accent),
              ),
            ),
          ),
          const EMHeight(28),
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: (!canSubmit || submitting.value) ? null : handleSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: submitting.value
                    ? AppColors.accent
                    : AppColors.textMuted.withValues(alpha: 0.18),
                disabledForegroundColor: submitting.value
                    ? Colors.white
                    : AppColors.textMuted,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: submitting.value
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.4,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      submitLabel,
                      style: NotoSansKR.semiBold.set(size: 16, fixedHeight: 16),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
