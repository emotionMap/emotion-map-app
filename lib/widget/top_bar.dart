part of 'index.dart';

/// 피드/글쓰기/지도/마이페이지 4개 하단탭 화면의 상단탭 타이포그래피·아이콘 배치를 하나로 묶는다.
/// 배경색은 화면마다 다를 수 있어(지도의 낮/밤 테마) color만 주입받는다.
class EMTopBarTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color color;
  final Color? iconColor;

  const EMTopBarTitle({
    super.key,
    required this.title,
    this.icon,
    required this.color,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 20, color: iconColor ?? color),
          const EMWidth(8),
        ],
        Text(title, style: NotoSansKR.bold.set(size: 18, color: color)),
      ],
    );
  }
}

/// 일반 Scaffold.appBar 자리에 그대로 꽂는 공용 상단탭 (피드/글쓰기/마이페이지).
/// 지도 화면은 낮/밤 그라데이션이 상태바까지 이어져야 해서 AppBar 대신
/// [EMTopBarTitle]을 자체 헤더 안에서 직접 사용한다.
class EMTopBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final IconData? icon;

  const EMTopBar({super.key, required this.title, this.icon});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: EMTopBarTitle(
        title: title,
        icon: icon,
        color: AppColors.textPrimary,
      ),
    );
  }
}
