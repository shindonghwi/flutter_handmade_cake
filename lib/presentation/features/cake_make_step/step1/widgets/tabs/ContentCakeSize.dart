import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/provider/CakeSizeProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContentCakeSize extends HookConsumerWidget {
  const ContentCakeSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeSizeTypeList = [CakeSizeType.One, CakeSizeType.Two, CakeSizeType.Three];
    final cakeSizeManager = ref.read(cakeSizeProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: cakeSizeTypeList.map((size) {
        return Flexible(
          flex: 1,
          fit: FlexFit.tight,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Clickable(
              borderRadius: 100,
              onPressed: () => cakeSizeManager.changeSize(size),
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
                    size.sizeType,
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
