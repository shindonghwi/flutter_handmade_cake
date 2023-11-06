import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/features/main/home/widgets/SecondTab.dart';

class SampleCakeScreen extends HookWidget {
  const SampleCakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const BaseScaffold(
      backgroundColor: Colors.white,
      appBar: TopBarIconTitleText(
        content: '케이크 구경하기',
      ),
      body: SecondTab(),
    );
  }
}
