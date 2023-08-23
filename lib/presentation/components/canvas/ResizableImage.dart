import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final focusedWidgetProvider = StateProvider<String?>((_) => null);

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
    final focusedWidgetKey = ref.watch(focusedWidgetProvider);
    final focusedWidgetKeyRead = ref.read(focusedWidgetProvider.notifier);
    final position = useState<Offset>(const Offset(0, 0));
    final size = useState<Size>(const Size(100, 100));

    const aspectRatio = 1.0;

    useEffect(() {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        focusedWidgetKeyRead.state = widgetKey;
      });
      return null;
    }, []);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: position.value.dx,
              top: position.value.dy,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (focusedWidgetKeyRead.state == widgetKey) {
                    focusedWidgetKeyRead.state = null;
                    return;
                  }
                  focusedWidgetKeyRead.state = widgetKey;
                },
                onPanUpdate: focusedWidgetKey == widgetKey
                    ? (details) {
                        double newDx = position.value.dx + details.delta.dx;
                        double newDy = position.value.dy + details.delta.dy;

                        double maxWidth = constraints.maxWidth - size.value.width + 10;
                        double maxHeight = constraints.maxHeight - size.value.height + 10;

                        double minWidth = -10;
                        double minHeight = -10;

                        newDx = newDx.clamp(minWidth, maxWidth);
                        newDy = newDy.clamp(minHeight, maxHeight);

                        position.value = Offset(newDx, newDy);
                      }
                    : null,
                child: Container(
                  width: size.value.width,
                  height: size.value.height,
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
            if (focusedWidgetKey == widgetKey) ...[
              // Bottom-right corner for resizing
              Positioned(
                left: position.value.dx + size.value.width - 25,
                top: position.value.dy + size.value.height - 25,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    double delta = details.delta.dx;
                    double newWidth = size.value.width + delta;
                    double newHeight = newWidth / aspectRatio;

                    if (newWidth < 50) {
                      newWidth = 50;
                      newHeight = newWidth / aspectRatio;
                    }

                    if (newWidth > 200) {
                      newWidth = 200;
                      newHeight = newWidth / aspectRatio;
                    }

                    size.value = Size(newWidth, newHeight);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: position.value.dx + size.value.width - 6,
                top: position.value.dy + size.value.height - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorScheme(context).colorPrimary500,
                  ),
                ),
              ),

              // Bottom-left corner for resizing
              Positioned(
                left: position.value.dx - 25,
                top: position.value.dy + size.value.height - 25,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    double deltaWidth = -details.delta.dx;
                    double deltaHeight = deltaWidth / aspectRatio;

                    double newWidth = size.value.width + deltaWidth;
                    double newHeight = size.value.height + deltaHeight;

                    // Constraints to ensure the size is between 50 and 200
                    if (newWidth < 50) {
                      newWidth = 50;
                      newHeight = newWidth / aspectRatio;
                    } else if (newWidth > 200) {
                      newWidth = 200;
                      newHeight = newWidth / aspectRatio;
                    }

                    // Adjust position so top-right stays in place
                    position.value = Offset(position.value.dx - (newWidth - size.value.width), position.value.dy);

                    size.value = Size(newWidth, newHeight);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: position.value.dx - 6,
                top: position.value.dy + size.value.height - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorScheme(context).colorPrimary500,
                  ),
                ),
              ),
              // Top-left corner for resizing
              Positioned(
                left: position.value.dx - 25,
                top: position.value.dy - 25,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    double deltaWidth = -details.delta.dx;
                    double deltaHeight = deltaWidth / aspectRatio;

                    double newWidth = size.value.width + deltaWidth;
                    double newHeight = size.value.height + deltaHeight;

                    // Constraints to ensure the size is between 50 and 200
                    if (newWidth < 50) {
                      newWidth = 50;
                      newHeight = newWidth / aspectRatio;
                    } else if (newWidth > 200) {
                      newWidth = 200;
                      newHeight = newWidth / aspectRatio;
                    }

                    // Adjust position so bottom-right stays in place
                    position.value = Offset(position.value.dx - (newWidth - size.value.width),
                        position.value.dy - (newHeight - size.value.height));

                    size.value = Size(newWidth, newHeight);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: position.value.dx - 6,
                top: position.value.dy - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorScheme(context).colorPrimary500,
                  ),
                ),
              ),
// Top-right corner for resizing
              Positioned(
                left: position.value.dx + size.value.width - 25,
                top: position.value.dy - 25,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onPanUpdate: (details) {
                    double deltaWidth = details.delta.dx;
                    double deltaHeight = deltaWidth / aspectRatio;

                    double newWidth = size.value.width + deltaWidth;
                    double newHeight = size.value.height + deltaHeight;

                    // Constraints to ensure the size is between 50 and 200
                    if (newWidth < 50) {
                      newWidth = 50;
                      newHeight = newWidth / aspectRatio;
                    } else if (newWidth > 200) {
                      newWidth = 200;
                      newHeight = newWidth / aspectRatio;
                    }

                    // Adjust position so bottom-left stays in place
                    position.value = Offset(position.value.dx, position.value.dy - (newHeight - size.value.height));

                    size.value = Size(newWidth, newHeight);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: position.value.dx + size.value.width - 6,
                top: position.value.dy - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColorScheme(context).colorPrimary500,
                  ),
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
