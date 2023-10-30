import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/provider/CakeFilingProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentCakeFiling extends HookConsumerWidget {
  const ContentCakeFiling({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filingList = [FilingType.Blueberry, FilingType.Strawberry, FilingType.Raspberry, FilingType.Apricot];
    final cakeFilingManager = ref.read(cakeFilingProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: filingList.map((filing) {
        return Clickable(
          borderRadius: 100,
          onPressed: () => cakeFilingManager.changeFiling(filing),
          child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColorScheme(context).colorPrimary500,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
                child: Text(
                  filing.filingType,
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 12,
                        color: getColorScheme(context).colorPrimary500,
                      ),
                ),
              )),
        );
      }).toList(),
    );
  }
}
