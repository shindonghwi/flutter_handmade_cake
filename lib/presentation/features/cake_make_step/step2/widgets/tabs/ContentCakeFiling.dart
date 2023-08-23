import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final makeCakeFilingProvider = StateProvider.autoDispose<String>((ref) => "블루베리");

class ContentCakeFiling extends HookConsumerWidget {
  const ContentCakeFiling({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final makeCakeFilingState = ref.watch(makeCakeFilingProvider);
    final makeCakeFilingRead = ref.read(makeCakeFilingProvider.notifier);

    final List<String> sheets = [
      "블루베리",
      "딸기",
      "라즈베리",
      "애플망고",
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
              color: makeCakeFilingState == sheet
                  ? getColorScheme(context).colorPrimary500
                  : getColorScheme(context).colorGray300,
            ),
            borderRadius: BorderRadius.circular(100),
            color: makeCakeFilingState == sheet
                ? getColorScheme(context).colorPrimary500.withOpacity(0.05)
                : getColorScheme(context).white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (makeCakeFilingState == sheet) {
                   makeCakeFilingRead.state = "";
                   return;
                }
                makeCakeFilingRead.state = sheet;
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
                            color: makeCakeFilingState == sheet
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
