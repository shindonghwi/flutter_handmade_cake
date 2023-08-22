import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/features/home/HomeScreen.dart';
import 'package:handmade_cake/presentation/features/sign_in/SignInScreen.dart';
import 'package:handmade_cake/presentation/features/signup/SignUpScreen.dart';
import 'package:handmade_cake/presentation/features/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시ㅣ
  SignIn(route: "/signin"), // 로그인
  SignUp(route: "/signup"), // 회원가입
  Home(route: "/home"); // 홈

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.SignIn.route: (context) => const SignInScreen(),
      RoutingScreen.SignUp.route: (context) => const SignUpScreen(),
      RoutingScreen.Home.route: (context) => const HomeScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    debugPrint("getScreen : parameter: $parameter");
    switch (route) {
      case "/splash":
        return const SplashScreen();
      case "/signin":
        return const SignInScreen();
      case "/signup":
        return const SignUpScreen();
      case "/home":
        return const HomeScreen();
      default:
        return const SignInScreen();
    }
  }
}
