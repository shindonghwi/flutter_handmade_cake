import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final makeCakeColorProvider = StateProvider.autoDispose<Color>((ref) => const Color(0xFFF5F5F5));

class ContentCakeColor extends HookConsumerWidget {
  const ContentCakeColor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final makeCakeColorState = ref.watch(makeCakeColorProvider);
    final makeCakeColorRead = ref.read(makeCakeColorProvider.notifier);

    final colors = [
      const Color(0xFFF5F5F5),
      const Color(0xFFFF8080),
      const Color(0xFFFFCC99),
      const Color(0xFFFFFFCC),
      const Color(0xFF80FF80),
      const Color(0xFF80CCFF),
      const Color(0xFF9999FF),
      const Color(0xFFCC99FF),
      const Color(0xFFD2B48C),
    ];

    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12.0),
      itemBuilder: (context, index) {
        final color = colors[index];
        return ClipOval(
          child: Clickable(
            onPressed: (){
              makeCakeColorRead.state = color;
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: getColorScheme(context).colorPrimary500,
                ),
                // borderRadius: BorderRadius.circular(100),
                color: color,
                shape: BoxShape.circle,
              ),
              child: Align(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  "assets/imgs/icon_check.svg",
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).colorPrimary500.withOpacity(
                          makeCakeColorState == color ? 1 : 0.2,
                        ),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: 20);
      },
      itemCount: colors.length,
    );
  }
}
