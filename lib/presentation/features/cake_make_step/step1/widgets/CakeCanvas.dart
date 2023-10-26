import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/CanvasWidgetsNotifier.dart';
import 'tabs/ContentCakeFlavor.dart';

class CakeCanvas extends HookConsumerWidget {
  const CakeCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgets = ref.watch(canvasWidgetsProvider);
    final canvasWidgetsRead = ref.read(canvasWidgetsProvider.notifier);
    final cakeColor = ref.watch(makeCakeColorProvider);

    debugPrint("canvasWidgets: ${canvasWidgets.length}");

    useEffect(() {
      return (){
        Future((){
          canvasWidgetsRead.clearAll();
        });
      };
    }, []);

    // useEffect(() {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     final cakeBackgroundWidget = getCakeShape(cakeShape, cakeColor);
    //     canvasWidgetsRead.setBackgroundWidget(Positioned.fill(
    //       child: cakeBackgroundWidget,
    //     ));
    //   });
    //   return null;
    // }, [cakeShape, cakeColor]);

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
              child: Stack(
                children: canvasWidgets.map((e) => e).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
