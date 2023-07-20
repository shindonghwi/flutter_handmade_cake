import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handmade_cake/app/HandMadeCakeApp.dart';
import 'package:handmade_cake/di/locator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum BuildType { dev, prod }

class Environment {
  const Environment._internal(this._buildType);

  final BuildType _buildType;
  static Environment _instance = const Environment._internal(BuildType.dev);

  static Environment get instance => _instance;

  static BuildType get buildType => _instance._buildType;

  static String get apiUrl => _instance._buildType == BuildType.dev ? '' : ''; // api 주소

  static String get apiVersion =>
      _instance._buildType == BuildType.dev ? 'v1' : 'v1'; // api Version

  factory Environment.newInstance(BuildType buildType) {
    _instance = Environment._internal(buildType);
    return _instance;
  }

  bool get isDebuggable => _buildType == BuildType.dev;

  void run() async {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    initServiceLocator();

    runApp(const ProviderScope(child: HandMadeCakeApp()));
  }
}
