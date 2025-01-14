import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../provider/CakeFilingProvider.dart';
import '../../../provider/CakeIndentProvider.dart';

class ContentCakeFiling extends HookConsumerWidget {
  const ContentCakeFiling({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filingList = [FilingType.Blueberry, FilingType.Strawberry, FilingType.Raspberry, FilingType.Apricot];
    final cakeFilingManager = ref.read(cakeFilingProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filingList.map((filing) {
        return Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Clickable(
              borderRadius: 100,
              onPressed: () {
                cakeIndentManager.updateJam(filing);
                cakeFilingManager.changeFiling(filing);
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
                    filing.filingType,
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
