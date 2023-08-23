import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final makeCakeSheetProvider = StateProvider.autoDispose<String>((ref) => "");

class ContentCakeSheet extends HookConsumerWidget {
  const ContentCakeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final makeCakeSheetState = ref.watch(makeCakeSheetProvider);
    final makeCakeSheetRead = ref.read(makeCakeSheetProvider.notifier);

    final List<String> sheets = [
      "바닐라",
      "초코",
      "당근",
      "레드벨벳",
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
              color: makeCakeSheetState == sheet
                  ? getColorScheme(context).colorPrimary500
                  : getColorScheme(context).colorGray300,
            ),
            borderRadius: BorderRadius.circular(100),
            color: makeCakeSheetState == sheet
                ? getColorScheme(context).colorPrimary500.withOpacity(0.05)
                : getColorScheme(context).white,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                if (makeCakeSheetState == sheet) {
                  makeCakeSheetRead.state = "";
                  return;
                }
                makeCakeSheetRead.state = sheet;
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
                            color: makeCakeSheetState == sheet
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
