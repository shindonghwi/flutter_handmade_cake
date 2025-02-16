import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/canvas/ResizableImage.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeIndentProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/dto/Pair.dart';
import 'package:handmade_cake/presentation/utils/dto/Triple.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../provider/CanvasWidgetsProvider.dart';

class ContentCakeDecoration extends HookConsumerWidget {
  const ContentCakeDecoration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgetsRead = ref.read(canvasWidgetsProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    final List<Triple<String, String, int>> decorations = [
      Triple("수국1", "assets/imgs/deco1.png", 5000), // 1
      Triple("수국2", "assets/imgs/deco2.png", 5000), // 1
      Triple("장미1", "assets/imgs/deco3.png", 2000), // 3
      Triple("장미2", "assets/imgs/deco4.png", 2000), // 3
      Triple("장미3", "assets/imgs/deco5.png", 2000), // 3
      Triple("데이지", "assets/imgs/deco6.png", 1000), // 4
      Triple("벚꽃", "assets/imgs/deco7.png", 1000), // 1
      Triple("접시꽃", "assets/imgs/deco8.png", 2000), // 2
      Triple("백일홍", "assets/imgs/deco9.png", 1000), // 4
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 0.0, bottom: 4),
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
        Container(
          height: 110,
          margin: const EdgeInsets.only(top: 12.0, bottom: 16.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final deco = decorations[index];
              return Stack(
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
                            deco.second,
                            width: 50,
                            height: 50,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          deco.first,
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 12,
                                color: getColorScheme(context).colorPrimary500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "${NumberFormat('#,###').format(deco.third)}원",
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
                        if (canvasWidgetsRead.getSize() == 0) {
                          Toast.showWarning(context, "시트를 먼저 선택해주세요");
                          return;
                        }

                        final name = deco.first;

                        String getDecorationType(String name) {
                          switch (name) {
                            case "수국1":
                              return "HY1";
                            case "수국2":
                              return "HY2";
                            case "장미1":
                              return "RS1";
                            case "장미2":
                              return "RS2";
                            case "장미3":
                              return "RS3";
                            case "데이지":
                              return "DS1";
                            case "벚꽃":
                              return "CB1";
                            case "접시꽃":
                              return "HH1";
                            case "백일홍":
                              return "CM1";
                            default:
                              return "";
                          }
                        }

                        cakeIndentManager.addDecoration(getDecorationType(name));

                        final widgetKey = "${deco.first}_${DateTime.now().millisecondsSinceEpoch}";

                        canvasWidgetsRead.addWidget(
                          ResizableImage(
                            widgetKey: widgetKey,
                            path: deco.second,
                            decorationType: getDecorationType(name),
                          ),
                          widgetKey,
                          getDecorationType(name),
                        );
                      },
                      child: Container(),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemCount: decorations.length,
          ),
        ),
      ],
    );
  }
}
