/// 서버 createdAt(ISO-8601 문자열)을 "방금 전 / n분 전 / n시간 전 / n일 전"으로 변환.
/// 새 패키지(intl 등) 추가 없이 순수 Dart 계산으로 처리.
String relativeTime(String? isoCreatedAt) {
  if (isoCreatedAt == null) return '';

  final createdAt = DateTime.tryParse(isoCreatedAt);
  if (createdAt == null) return '';

  final diff = DateTime.now().difference(createdAt);

  if (diff.inSeconds < 60) return '방금 전';
  if (diff.inMinutes < 60) return '${diff.inMinutes}분 전';
  if (diff.inHours < 24) return '${diff.inHours}시간 전';
  if (diff.inDays < 7) return '${diff.inDays}일 전';

  return '${createdAt.year}.${createdAt.month.toString().padLeft(2, '0')}.${createdAt.day.toString().padLeft(2, '0')}';
}

/// 서버 createdAt(ISO-8601 문자열)을 "yyyy-MM-dd HH:mm" 절대시간으로 변환.
String absoluteTime(String? isoCreatedAt) {
  if (isoCreatedAt == null) return '';

  final createdAt = DateTime.tryParse(isoCreatedAt);
  if (createdAt == null) return '';

  final y = createdAt.year.toString().padLeft(4, '0');
  final m = createdAt.month.toString().padLeft(2, '0');
  final d = createdAt.day.toString().padLeft(2, '0');
  final h = createdAt.hour.toString().padLeft(2, '0');
  final min = createdAt.minute.toString().padLeft(2, '0');

  return '$y-$m-$d $h:$min';
}
