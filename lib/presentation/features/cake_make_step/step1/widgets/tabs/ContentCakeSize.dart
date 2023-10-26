import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final makeCakeSizeProvider = StateProvider.autoDispose<String>((ref) => "1호 [10cm]");

class ContentCakeSize extends HookConsumerWidget {
  const ContentCakeSize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final makeCakeSizeState = ref.watch(makeCakeSizeProvider);
    final makeCakeSizeRead = ref.read(makeCakeSizeProvider.notifier);

    final List<String> sheets = [
      "1호 [10cm]",
      "2호 [20cm]",
      "3호 [30cm]",
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16.0),
      itemBuilder: (context, index) {
        final sheet = sheets[index];
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: makeCakeSizeState == sheet
                  ? getColorScheme(context).colorPrimary500
                  : getColorScheme(context).colorGray300,
            ),
            borderRadius: BorderRadius.circular(100),
            color: makeCakeSizeState == sheet
                ? getColorScheme(context).colorPrimary500.withOpacity(0.05)
                : getColorScheme(context).white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (makeCakeSizeState == sheet) {
                  makeCakeSizeRead.state = "";
                  return;
                }
                makeCakeSizeRead.state = sheet;
              },
              borderRadius: BorderRadius.circular(100),
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      sheet,
                      style: getTextTheme(context).medium.copyWith(
                            fontSize: 12,
                            color: makeCakeSizeState == sheet
                                ? getColorScheme(context).colorPrimary500
                                : getColorScheme(context).colorGray300,
                          ),
                    ),
                  )),
            ),
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
