import 'package:flutter/material.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:oauthapp/_core/http.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            GestureDetector(
              child: Image.asset(
                'assets/kakao_button.png',
                width: 200,
                height: 50,
              ),
              onTap: () async {
                kakaoLogin();
              },
            ),
            SizedBox(height: 50),
            GestureDetector(
              child: Image.asset(
                'assets/btnG_완성형.png',
                width: 200,
                height: 50,
              ),
              onTap: () async {
                try {
                  // Credential ( 자격, 증명 ) 로그인
                  // 1. 토큰 받기
                  NaverLoginResult res = await FlutterNaverLogin.logIn();

                  final name = res.account.name;
                  print("🎅🎅🎅🎅🎅🎅🎅🎅🎅🎅🎅🎅"
                      "");
                  print(name);

                  // 5d-z-zHOlZWZt5-LyckzQOAoPtoxUU-NAAAAAQo9c-wAAAGP3QKOd5gXPJRhmZ-F
                  print("네이버계정으로 로그인 성공 ${res.accessToken}");

                  // 2. 토큰( 카카오 )을 스프링서버에 전달하기 ( 스프링 서버한테 인증했다고 알려주기 )
                  final response = await dio.get("/oauth/callback",
                      queryParameters: {"accessToken": res.accessToken});

                  // 3. 토큰( 스프링서버 ) 응답받기
                  final blogAccessToken =
                      response.headers["Authorization"]!.first;
                  print("blogAccessToken : ${blogAccessToken}");

                  // 4. 시큐어 스토리지에 저장
                  secureStorage.write(
                      key: "blogAccessToken", value: blogAccessToken);

                  // 5. static, const 변수,riverpod 상태관리 ( 생략 )
                } catch (error) {
                  print("네이버계정으로 로그인 실패 $error");
                }
              },
            ),
          ],
        ),
      ),
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
