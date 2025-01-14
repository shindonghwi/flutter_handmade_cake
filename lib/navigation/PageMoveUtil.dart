import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:handmade_cake/navigation/Route.dart';

PageRoute nextSlideScreen(String route, {dynamic parameter}) {
  if (Platform.isIOS) {
    return CupertinoPageRoute(
      builder: (context) => RoutingScreen.getScreen(route, parameter: parameter),
    );
  } else {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(route, parameter: parameter),
      reverseTransitionDuration: const Duration(milliseconds: 250),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0)).animate(animation),
          child: child,
        );
      },
    );
  }
}

PageRoute nextFadeInOutScreen(String route, {dynamic parameter}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => RoutingScreen.getScreen(route, parameter: parameter),
    reverseTransitionDuration: const Duration(milliseconds: 500),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}
