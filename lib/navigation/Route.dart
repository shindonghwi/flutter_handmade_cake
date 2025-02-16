import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/MakeCakeInfoScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step3/MakeCakePaymentScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step4/MakeCakeCompleteScreen.dart';
import 'package:handmade_cake/presentation/features/detail/DetailOrderScreen.dart';
import 'package:handmade_cake/presentation/features/main/MainScreen.dart';
import 'package:handmade_cake/presentation/features/main/home/widgets/SecondTab.dart';
import 'package:handmade_cake/presentation/features/main/mypage/MyPageScreen.dart';
import 'package:handmade_cake/presentation/features/main/orders/OrdersScreen.dart';
import 'package:handmade_cake/presentation/features/sample_cake/SampleCakeScreen.dart';
import 'package:handmade_cake/presentation/features/sign_in/SignInScreen.dart';
import 'package:handmade_cake/presentation/features/signup/SignUpScreen.dart';
import 'package:handmade_cake/presentation/features/splash/SplashScreen.dart';
import 'package:handmade_cake/presentation/features/webview/PaymentWebViewScreen.dart';
import 'package:handmade_cake/presentation/features/withdrawal/WithdrawalScreen.dart';

import '../presentation/features/cake_make_step/step1/MakeCakeDrawingScreen.dart';

enum RoutingScreen {
  Splash(route: "/splash"), // 스플래시ㅣ
  SignIn(route: "/signin"), // 로그인
  SignUp(route: "/signup"), // 회원가입
  Main(route: "/main"), // 메인
  SampleCake(route: "/sample/cake"), // 샘플 케이크 리스트
  Orders(route: "/orders"), // 주문 정보
  MyPage(route: "/mypage"), // 내 정보
  Withdrawal(route: "/withdrawal"), // 회원탈퇴 화면
  DetailOrder(route: "/detail/order"), // 주문 상세
  MakeCakeDrawing(route: "/make/drawing"), // 케이크 제작 그리기
  MakeCakeInfo(route: "/make/info"), // 케이크 정보 작성
  MakeCakePayment(route: "/make/payment"), // 케이크 결제하기
  PaymentWebView(route: "/payment/webview"), // 케이크 결제하기 웹뷰
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
      RoutingScreen.SampleCake.route: (context) => const SampleCakeScreen(),
      RoutingScreen.Orders.route: (context) => const OrdersScreen(),
      RoutingScreen.MyPage.route: (context) => const MyPageScreen(),
      RoutingScreen.Withdrawal.route: (context) => const WithdrawalScreen(),
      RoutingScreen.DetailOrder.route: (context) => const DetailOrderScreen(),
      RoutingScreen.MakeCakeDrawing.route: (context) => const MakeCakeDrawingScreen(),
      RoutingScreen.MakeCakeInfo.route: (context) => const MakeCakeInfoScreen(),
      RoutingScreen.MakeCakePayment.route: (context) => const MakeCakePaymentScreen(),
      RoutingScreen.PaymentWebView.route: (context) => const PaymentWebViewScreen(),
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
    } else if (route == RoutingScreen.SampleCake.route) {
      return const SampleCakeScreen();
    } else if (route == RoutingScreen.Orders.route) {
      return const OrdersScreen();
    } else if (route == RoutingScreen.MyPage.route) {
      return const MyPageScreen();
    } else if (route == RoutingScreen.Withdrawal.route) {
      return const WithdrawalScreen();
    } else if (route == RoutingScreen.DetailOrder.route) {
      int orderId = parameter;
      return DetailOrderScreen(orderId: orderId);
    } else if (route == RoutingScreen.MakeCakeDrawing.route) {
      return const MakeCakeDrawingScreen();
    } else if (route == RoutingScreen.MakeCakeInfo.route) {
      return const MakeCakeInfoScreen();
    } else if (route == RoutingScreen.MakeCakePayment.route) {
      return const MakeCakePaymentScreen();
    } else if (route == RoutingScreen.MakeCakeComplete.route) {
      return const MakeCakeCompleteScreen();
    } else if (route == RoutingScreen.PaymentWebView.route) {
      final webViewUrl = parameter;
      return PaymentWebViewScreen(webViewUrl: webViewUrl);
    } else {
      return const SignInScreen();
    }
  }
}
