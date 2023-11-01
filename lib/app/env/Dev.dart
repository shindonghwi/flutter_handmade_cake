import 'package:flutter/material.dart';
import 'package:handmade_cake/app/env/Environment.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.newInstance(BuildType.dev).run();
}
