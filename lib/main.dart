import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:oauthapp/_core/move.dart';

import 'ui/login_page/login_page.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하면 runApp() 호출 전! 아래 메서드 호출 필요!
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(nativeAppKey: '41fca0eb7efaf20d9302ca72cb12e274');
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      routes: getRouters(),
    );
  }
}
