import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/CanvasWidgetsNotifier.dart';

class ContentCakeOption extends HookConsumerWidget {
  const ContentCakeOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canvasWidgetsRead = ref.read(canvasWidgetsProvider.notifier);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: getColorScheme(context).colorPrimary500,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "맛: 바닐라",
                style: getTextTheme(context).medium.copyWith(
                      fontSize: 12,
                      color: getColorScheme(context).colorPrimary500,
                    ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: getColorScheme(context).colorPrimary500,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "맛: 바닐라",
                style: getTextTheme(context).medium.copyWith(
                      fontSize: 12,
                      color: getColorScheme(context).colorPrimary500,
                    ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: getColorScheme(context).colorPrimary500,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "맛: 바닐라",
                style: getTextTheme(context).medium.copyWith(
                      fontSize: 12,
                      color: getColorScheme(context).colorPrimary500,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
