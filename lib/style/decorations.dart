part of 'index.dart';

/// 카드·하단탭·입력바 등 화면마다 반복되던 "표면" 장식을 한 곳에서 정의한다.
/// 화면 코드에서 BoxDecoration을 직접 조립하지 말고 이 클래스를 통해서만 쓴다.
class AppDecorations {
  AppDecorations._();

  static BoxDecoration card({double radius = 16}) => BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: AppColors.border),
  );

  /// 하단탭, 댓글 입력바처럼 화면 상단 경계에 붙는 표면.
  static BoxDecoration elevatedBar({bool shadow = true}) => BoxDecoration(
    color: AppColors.surface,
    border: Border(top: BorderSide(color: AppColors.border)),
    boxShadow: shadow
        ? [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ]
        : null,
  );
}
