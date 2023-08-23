import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/painter/CircleClipper.dart';
import 'package:handmade_cake/presentation/components/painter/HeartClipper.dart';
import 'package:handmade_cake/presentation/components/painter/OctagonalClipper.dart';
import 'package:handmade_cake/presentation/components/painter/RectClipper.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/MakeCakeShapeScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/notifier/CanvasWidgetsNotifier.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/widgets/tabs/ContentCakeColor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CakeCanvas extends HookConsumerWidget {
  const CakeCanvas({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgets = ref.watch(canvasWidgetsStateProvider);
    final canvasWidgetsRead = ref.read(canvasWidgetsStateProvider.notifier);
    final cakeColor = ref.watch(makeCakeColorProvider);
    final cakeShape = ref.watch(makeCakeShapeProvider);

    debugPrint("canvasWidgets: ${canvasWidgets.length}");

    useEffect(() {
      canvasWidgetsRead.clearDecoration();
      return null;
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final cakeBackgroundWidget = getCakeShape(cakeShape, cakeColor);
        canvasWidgetsRead.setBackgroundWidget(Positioned.fill(
          child: cakeBackgroundWidget,
        ));
      });
      return null;
    }, [cakeShape, cakeColor]);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: canvasWidgets.map((e) => e).toList(),
            ),
          ),
        );
      },
    );
  }

  // cake 모양 가져오기
  Widget getCakeShape(CakeShape cakeShape, Color cakeColor) {
    debugPrint("CakeShape: $cakeShape / CakeColor: $cakeColor");
    if (cakeShape == CakeShape.CIRCLE) {
      return CustomPaint(painter: CircleClipper(backgroundColor: cakeColor));
    } else if (cakeShape == CakeShape.HEART) {
      return CustomPaint(painter: HeartClipper(backgroundColor: cakeColor));
    } else if (cakeShape == CakeShape.OCTAGON) {
      return CustomPaint(painter: OctagonalClipper(backgroundColor: cakeColor));
    } else {
      return CustomPaint(painter: RectClipper(backgroundColor: cakeColor));
    }
  }
}
