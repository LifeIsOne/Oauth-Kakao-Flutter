import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:oauthapp/_core/http.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("카카오 로그인"),
      ),
      body: ElevatedButton(
          child: Text("카카오 로그인"),
          onPressed: () async {
            kakaoLogin();
          }),
    );
  }

  void kakaoLogin() async {
    try {
      // Credential ( 자격, 증명 ) 로그인
      // 1. 토큰 받기
      OAuthToken token = await UserApi.instance.loginWithKakaoAccount();

      // 5d-z-zHOlZWZt5-LyckzQOAoPtoxUU-NAAAAAQo9c-wAAAGP3QKOd5gXPJRhmZ-F
      print('카카오계정으로 로그인 성공 ${token.accessToken}');

      // 2. 토큰( 카카오 )을 스프링서버에 전달하기 ( 스프링 서버한테 인증했다고 알려주기 )
      final response = await dio.get("/oauth/callback",
          queryParameters: {"accessToken": token.accessToken});

      // 3. 토큰( 스프링서버 ) 응답받기
      final blogAccessToken = response.headers["Authorization"]!.first;
      print("blogAccessToken : ${blogAccessToken}");

      // 4. 시큐어 스토리지에 저장
      secureStorage.write(key: "blogAccessToken", value: blogAccessToken);

      // 5. static, const 변수,riverpod 상태관리 ( 생략 )
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}
