import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/canvas/ResizableImage.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/notifier/CanvasWidgetsNotifier.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step2/widgets/CakeCanvas.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/dto/Pair.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentCakeDecoration extends HookConsumerWidget {
  const ContentCakeDecoration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgetsRead = ref.read(canvasWidgetsStateProvider.notifier);

    final List<Pair<String, String>> decorations = [
      Pair(
        "장미",
        "assets/imgs/deco_rose.png",
      ),
      Pair(
        "버섯",
        "assets/imgs/deco_rose.png",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 0.0, bottom: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: getColorScheme(context).black,
                width: 1,
              ),
            ),
          ),
          child: Text(
            "데코레이션",
            style: getTextTheme(context).medium.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).black,
                ),
          ),
        ),
        Row(
          children: decorations.map((decoration) {
            return Container(
              margin: const EdgeInsets.only(top: 16.0, right: 16.0),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: getColorScheme(context).colorGray300,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            decoration.second,
                            width: 50,
                            height: 50,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          decoration.first,
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 12,
                                color: getColorScheme(context).colorPrimary500,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Positioned.fill(
                    child: Clickable(
                      onPressed: () {
                        canvasWidgetsRead.addWidget(
                          ResizableImage(
                            widgetKey: "${decoration.first}_${DateTime.now().millisecondsSinceEpoch}",
                            path: decoration.second,
                          ),
                        );
                      },
                      child: Container(),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
