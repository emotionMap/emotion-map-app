import 'package:flutter/foundation.dart';

/// 하단탭에서 피드/마이 탭을 누르면 해당 신호가 증가한다.
/// 각 화면이 이 신호를 받아 목록을 맨 위로 스크롤한다.
final feedScrollToTopSignal = ValueNotifier<int>(0);
final myPageScrollToTopSignal = ValueNotifier<int>(0);
