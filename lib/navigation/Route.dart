import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/features/home/HomeScreen.dart';
import 'package:handmade_cake/presentation/features/sign_in/SignInScreen.dart';

enum RoutingScreen {
  SignIn(route: "/signin"), // 로그인
  Home(route: "/home"); // 홈

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.SignIn.route: (context) => const SignInScreen(),
      RoutingScreen.Home.route: (context) => const HomeScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    debugPrint("getScreen : parameter: $parameter");
    switch (route) {
      case "/signin":
        return const SignInScreen();
      case "/home":
        return const HomeScreen();
      default:
        return const SignInScreen();
    }
  }
}
