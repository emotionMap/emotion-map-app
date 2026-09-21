import 'package:emotion_map_app/generate/model/comment_response.dart';

/// [CommentResponse.children]은 자기참조 재귀 타입이라 openapi 코드젠이
/// 제대로 타입을 못 잡아 Object?(원본 JSON 그대로)로 내려온다.
/// 렌더링 시점에 필요한 depth에서만 이 헬퍼로 캐스팅한다.
List<CommentResponse> commentChildren(CommentResponse comment) {
  final raw = comment.children;
  if (raw is! List) return [];
  return raw
      .whereType<Map<String, dynamic>>()
      .map(CommentResponse.fromJson)
      .toList();
}
