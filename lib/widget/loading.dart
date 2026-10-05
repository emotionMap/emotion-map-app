part of 'index.dart';

/// 화면/섹션 단위 로딩 상태 공용 위젯. 화면마다 `Center(child: CircularProgressIndicator())`를
/// 따로 두지 않고 이걸로 통일한다. 지도처럼 배경 테마에 맞는 색이 필요하면 [color]만 주입.
class EMLoadingIndicator extends StatelessWidget {
  final Color? color;

  const EMLoadingIndicator({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(color: color));
  }
}

/// 버튼/목록 하단 "더 불러오는 중" 등 좁은 공간에 쓰는 작은 인라인 스피너.
class EMInlineSpinner extends StatelessWidget {
  final Color? color;
  final double size;

  const EMInlineSpinner({super.key, this.color, this.size = 22});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(strokeWidth: 2.4, color: color),
    );
  }
}
