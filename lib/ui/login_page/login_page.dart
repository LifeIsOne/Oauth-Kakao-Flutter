import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("카카오 로그인")),
      body: ElevatedButton(
        child: Text("카카오 로그인"),
        onPressed: kakaoLogin,
      ),
    );
  }

  void kakaoLogin() async {
    try {
      // 1. 크리덴셜 로그인 - 토큰 받기
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

      // Bdsfsdfsdfsadkl_+_
      print('카카오계정으로 로그인 성공 ${token.accessToken}');

      // 2. 토큰( 카카오 )을 스프링서버에 전달하기 ( 스프링 서버한테 인증했다고 알려주기 )

      // 3. 토큰( 스프링서버 ) 응답받기

      // 4. 시큐어 스토리지에 저장
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
