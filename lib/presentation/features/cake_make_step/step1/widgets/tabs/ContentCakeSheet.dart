import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/CakeIndentProvider.dart';
import '../../../provider/CanvasWidgetsProvider.dart';

class ContentCakeSheet extends HookConsumerWidget {
  const ContentCakeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasManager = ref.read(canvasWidgetsProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    final List<String> sheets = [
      "assets/imgs/sheet_circle_red.png",
      "assets/imgs/sheet_circle_white.png",
      "assets/imgs/sheet_circle_yellow.png",
      "assets/imgs/sheet_circle_blue.png",
      "assets/imgs/sheet_circle_green.png",
      "assets/imgs/sheet_heart_red.png",
      "assets/imgs/sheet_heart_white.png",
      "assets/imgs/sheet_heart_yellow.png",
      "assets/imgs/sheet_heart_blue.png",
      "assets/imgs/sheet_heart_green.png",
      "assets/imgs/sheet_rect_red.png",
      "assets/imgs/sheet_rect_white.png",
      "assets/imgs/sheet_rect_yellow.png",
      "assets/imgs/sheet_rect_blue.png",
      "assets/imgs/sheet_rect_green.png",
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12.0),
      itemBuilder: (context, index) {
        final sheet = sheets[index];

        var sheetKey = "SH";
        if (sheet.contains("rect")) {
          sheetKey += "S";
        } else if (sheet.contains("circle")) {
          sheetKey += "C";
        } else if (sheet.contains("heart")) {
          sheetKey += "H";
        }

        if (sheet.contains("white")) {
          sheetKey += "W";
        } else if (sheet.contains("yellow")) {
          sheetKey += "Y";
        } else if (sheet.contains("blue")) {
          sheetKey += "S";
        } else if (sheet.contains("green")) {
          sheetKey += "G";
        } else if (sheet.contains("red")) {
          sheetKey += "P";
        }

        return Clickable(
          onPressed: () {
            cakeIndentManager.updateCakeSheet(sheetKey);
            canvasManager.setBackgroundWidget(
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    sheet,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          child: Image.asset(
            sheet,
            fit: BoxFit.cover,
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 24);
      },
      itemCount: sheets.length,
    );
  }
}
