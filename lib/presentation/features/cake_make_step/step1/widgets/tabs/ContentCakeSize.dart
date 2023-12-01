import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/dto/Pair.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../provider/CakeIndentProvider.dart';
import '../../../provider/CakeSizeProvider.dart';

class ContentCakeSize extends HookConsumerWidget {
  const ContentCakeSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeSizeTypeList = [
      Pair(CakeSizeType.One, 40000),
      Pair(CakeSizeType.Two, 50000),
      Pair(CakeSizeType.Three, 60000),
    ];
    final cakeSizeManager = ref.read(cakeSizeProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

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
              onPressed: () {
                cakeIndentManager.updateCakeSize(size.first);
                cakeSizeManager.changeSize(size.first);
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Text(
                    "${size.first.sizeType}\n${NumberFormat("#,###").format(size.second)}원",
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
