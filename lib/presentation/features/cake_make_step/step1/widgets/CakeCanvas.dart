import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/CanvasWidgetsProvider.dart';
import '../MakeCakeDrawingScreen.dart';



class CakeCanvas extends HookConsumerWidget {
  const CakeCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgets = ref.watch(canvasWidgetsProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.only(top: 4, bottom: 20),
          child: AspectRatio(
            aspectRatio: 342 / 260,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColorScheme(context).colorGray300,
                  width: 1,
                ),
              ),
              child: RepaintBoundary(
                key: canvasGlobalKey, // Attach the global key here
                child: Stack(
                  children: canvasWidgets.map((e) => e.first).toList(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
