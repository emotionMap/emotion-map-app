/// 서버 createdAt(ISO-8601 문자열)을 트위터식 하이브리드 표기로 변환.
/// 24시간 이내: "방금 전 / n분 전 / n시간 전", 24시간 이후: "yyyy-MM-dd HH:mm" 절대시간.
/// 감정 기록은 "언제"가 핵심 데이터라 24시간이 지나면 상대시간이 아닌 정확한 시각을 보여준다.
/// 새 패키지(intl 등) 추가 없이 순수 Dart 계산으로 처리.
String displayTime(String? isoCreatedAt) {
  if (isoCreatedAt == null) return '';

  final createdAt = DateTime.tryParse(isoCreatedAt);
  if (createdAt == null) return '';

  final diff = DateTime.now().difference(createdAt);

  if (diff.inHours < 24) {
    if (diff.inSeconds < 60) return '방금 전';
    if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
    return '${diff.inHours}시간 전';
  }

  final y = createdAt.year.toString().padLeft(4, '0');
  final m = createdAt.month.toString().padLeft(2, '0');
  final d = createdAt.day.toString().padLeft(2, '0');
  final h = createdAt.hour.toString().padLeft(2, '0');
  final min = createdAt.minute.toString().padLeft(2, '0');

  return '$y-$m-$d $h:$min';
}
