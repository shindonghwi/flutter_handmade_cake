import 'package:flutter/material.dart';
import 'package:handmade_cake/app/env/Environment.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //
  // // 모든 오류 기록
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  //
  // // 플러터 외부 오류 기록
  // Isolate.current.addErrorListener(RawReceivePort((pair) async {
  //   final List<dynamic> errorAndStacktrace = pair;
  //   await FirebaseCrashlytics.instance.recordError(
  //     errorAndStacktrace.first,
  //     errorAndStacktrace.last,
  //   );
  // }).sendPort);

  Environment.newInstance(BuildType.prod).run();
}
