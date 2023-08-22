import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/MakeCakeShapeScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/MakeCakeDrawingScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step3/MakeCakeInfoScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step4/MakeCakePaymentScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step5/MakeCakeCompleteScreen.dart';
import 'package:handmade_cake/presentation/features/main/MainScreen.dart';
import 'package:handmade_cake/presentation/features/main/mypage/MyPageScreen.dart';
import 'package:handmade_cake/presentation/features/main/orders/OrdersScreen.dart';
import 'package:handmade_cake/presentation/features/sign_in/SignInScreen.dart';
import 'package:handmade_cake/presentation/features/signup/SignUpScreen.dart';
import 'package:handmade_cake/presentation/features/splash/SplashScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시ㅣ
  SignIn(route: "/signin"), // 로그인
  SignUp(route: "/signup"), // 회원가입
  Main(route: "/main"), // 메인
  Orders(route: "/orders"), // 주문 정보
  MyPage(route: "/mypage"), // 내 정보
  MakeCakeShape(route: "/make/shape"), // 케이크 모양 선택
  MakeCakeDrawing(route: "/make/drawing"), // 케이크 제작 그리기
  MakeCakeInfo(route: "/make/info"), // 케이크 정보 작성
  MakeCakePayment(route: "/make/payment"), // 케이크 결제하기
  MakeCakeComplete(route: "/make/complete"); // 케이크 주문 완료

  final String route;

  const RoutingScreen({
    required this.route,
  });

  static Map<String, WidgetBuilder> getAppRoutes() {
    return {
      RoutingScreen.Splash.route: (context) => const SplashScreen(),
      RoutingScreen.SignIn.route: (context) => const SignInScreen(),
      RoutingScreen.SignUp.route: (context) => const SignUpScreen(),
      RoutingScreen.Main.route: (context) => const MainScreen(),
      RoutingScreen.Orders.route: (context) => const OrdersScreen(),
      RoutingScreen.MyPage.route: (context) => const MyPageScreen(),
      RoutingScreen.MakeCakeShape.route: (context) => const MakeCakeShapeScreen(),
      RoutingScreen.MakeCakeDrawing.route: (context) => const MakeCakeDrawingScreen(),
      RoutingScreen.MakeCakeInfo.route: (context) => const MakeCakeInfoScreen(),
      RoutingScreen.MakeCakePayment.route: (context) => const MakeCakePaymentScreen(),
      RoutingScreen.MakeCakeComplete.route: (context) => const MakeCakeCompleteScreen(),
    };
  }

  static getScreen(String route, {dynamic parameter}) {
    debugPrint("getScreen : parameter: $parameter");

    if (route == RoutingScreen.Splash.route) {
      return const SplashScreen();
    } else if (route == RoutingScreen.SignIn.route) {
      return const SignInScreen();
    } else if (route == RoutingScreen.SignUp.route) {
      return const SignUpScreen();
    } else if (route == RoutingScreen.Main.route) {
      return const MainScreen();
    } else if (route == RoutingScreen.Orders.route) {
      return const OrdersScreen();
    } else if (route == RoutingScreen.MyPage.route) {
      return const MyPageScreen();
    } else if (route == RoutingScreen.MakeCakeShape.route) {
      return const MakeCakeShapeScreen();
    } else if (route == RoutingScreen.MakeCakeDrawing.route) {
      return const MakeCakeDrawingScreen();
    } else if (route == RoutingScreen.MakeCakeInfo.route) {
      return const MakeCakeInfoScreen();
    } else if (route == RoutingScreen.MakeCakePayment.route) {
      return const MakeCakePaymentScreen();
    } else if (route == RoutingScreen.MakeCakeComplete.route) {
      return const MakeCakeCompleteScreen();
    } else {
      return const SignInScreen();
    }
  }
}
