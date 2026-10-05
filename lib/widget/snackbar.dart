part of 'index.dart';

/// 화면마다 반복되던 `ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(...)))`를
/// 한 곳으로 모은 공용 헬퍼.
void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

/// 에러 처리 전용. [error]가 서비스 레이어에서 올라온 실제 안내 문구(String)면 그걸 그대로 보여주고,
/// 없으면(네트워크 취소/파싱 실패 등) [fallback]을 보여준다. 화면마다 실패 원인과 무관하게
/// 같은 문구만 뜨던 문제를 고치기 위함 - util/error.dart의 getErrorMessage()가 백엔드
/// ErrorResponse.error.message를 그대로 돌려준다.
void showErrorSnackBar(
  BuildContext context,
  Object error, {
  required String fallback,
}) {
  final message = (error is String && error.isNotEmpty) ? error : fallback;
  showAppSnackBar(context, message);
}
