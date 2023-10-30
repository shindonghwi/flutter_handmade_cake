import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/provider/CakeFlavorProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentCakeOption extends HookConsumerWidget {
  const ContentCakeOption({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeFlavor = ref.watch(cakeFlavorProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
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
                  "맛: ${cakeFlavor.flavorType}",
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 12,
                        color: getColorScheme(context).colorPrimary500,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
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
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: Container(
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
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
