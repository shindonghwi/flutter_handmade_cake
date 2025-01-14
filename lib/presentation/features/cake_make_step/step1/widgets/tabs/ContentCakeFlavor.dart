import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/CakeFlavorProvider.dart';
import '../../../provider/CakeIndentProvider.dart';

class ContentCakeFlavor extends HookConsumerWidget {
  const ContentCakeFlavor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorList = [FlavorType.Vanilla, FlavorType.Choco, FlavorType.Carrot, FlavorType.RedVelvet];
    final cakeFlavorManager = ref.read(cakeFlavorProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: flavorList.map((flavor) {
        return Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Clickable(
              borderRadius: 100,
              onPressed: () {
                cakeIndentManager.updateTaste(flavor);
                cakeFlavorManager.changeFlavor(flavor);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: getColorScheme(context).colorPrimary500,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  child: Text(
                    flavor.flavorType,
                    style: getTextTheme(context).medium.copyWith(
                          fontSize: 12,
                          color: getColorScheme(context).colorPrimary500,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
