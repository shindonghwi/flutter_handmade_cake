import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CanvasWidgetsProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/cake_make_step/step1/MakeCakeDrawingScreen.dart';

final focusedWidgetProvider = StateProvider<String?>((_) => null);

class PositionController extends StateNotifier<Offset> {
  PositionController() : super(const Offset(0, 0));

  void setPosition(Offset newPosition) {
    state = newPosition;
  }

  Offset getPosition() {
    return state;
  }
}

final positionProvider = StateNotifierProvider.family<PositionController, Offset, String>(
  (ref, widgetKey) => PositionController(),
);

class ResizableImage extends HookConsumerWidget {
  final String widgetKey;
  final String path;

  const ResizableImage({
    Key? key,
    required this.widgetKey,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgetsManager = ref.read(canvasWidgetsProvider.notifier);
    final allowScrollManager = ref.read(scrollProvider.notifier);
    final focusedWidgetKey = ref.watch(focusedWidgetProvider);
    final focusedWidgetKeManager = ref.read(focusedWidgetProvider.notifier);

    final positionController = ref.watch(positionProvider(widgetKey));
    final positionControllerManager = ref.read(positionProvider(widgetKey).notifier);

    final size = useState<Size>(const Size(50, 50));

    if (path.contains("deco1") || path.contains("deco2") || path.contains("deco7")) {
      size.value = const Size(120, 120);
    } else if (path.contains("deco8")) {
      size.value = const Size(50, 50);
    } else if (path.contains("deco3") || path.contains("deco4") || path.contains("deco5")) {
      size.value = const Size(40, 40);
    } else if (path.contains("deco6") || path.contains("deco9")) {
      size.value = const Size(30, 30);
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        focusedWidgetKeManager.state = widgetKey;
      });
      return null;
    }, []);

    return LayoutBuilder(
      key: Key(widgetKey),
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: positionControllerManager.getPosition().dx,
              top: positionControllerManager.getPosition().dy,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  // 포커스 상태 변경
                  if (focusedWidgetKeManager.state == widgetKey) {
                    focusedWidgetKeManager.state = null;
                  } else {
                    focusedWidgetKeManager.state = widgetKey;
                  }
                },
                onPanDown: (details) {
                  allowScrollManager.state = false;
                },
                onPanEnd: (details) {
                  allowScrollManager.state = true;
                },
                onPanCancel: () {
                  allowScrollManager.state = true;
                },
                onPanUpdate: focusedWidgetKey == widgetKey
                    ? (details) {
                        double newDx = positionControllerManager.getPosition().dx + details.delta.dx;
                        double newDy = positionControllerManager.getPosition().dy + details.delta.dy;

                        double maxWidth = constraints.maxWidth - size.value.width + 10;
                        double maxHeight = constraints.maxHeight - size.value.height + 10;

                        double minWidth = -10;
                        double minHeight = -10;

                        newDx = newDx.clamp(minWidth, maxWidth);
                        newDy = newDy.clamp(minHeight, maxHeight);

                        positionControllerManager.setPosition(Offset(newDx, newDy));
                      }
                    : null,
                child: Container(
                  width: size.value.width,
                  height: size.value.height,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: focusedWidgetKey == widgetKey
                        ? Border.all(color: getColorScheme(context).colorPrimary500, width: 2.0)
                        : null,
                    image: DecorationImage(
                      image: AssetImage(path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            if (focusedWidgetKey == widgetKey)
              Positioned(
                width: 40,
                height: 40,
                right: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Clickable(
                    onPressed: () {
                      canvasWidgetsManager.removeWidget(widgetKey);
                      focusedWidgetKeManager.state = null;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(
                        "assets/imgs/icon_trash.svg",
                        width: 24,
                        height: 24,
                        colorFilter: ColorFilter.mode(
                          getColorScheme(context).colorError500,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
