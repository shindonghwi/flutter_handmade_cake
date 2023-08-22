import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class FirstTab extends HookWidget {
  const FirstTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/imgs/image_home_cake.svg",
            width: 100,
            height: 100,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Make Moment',
            style: getTextTheme(context).semiBold.copyWith(
                  fontSize: 24,
                  color: getColorScheme(context).black,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            '고객님의 행복한 순간을 만들어드리는 케이크\n메이크모먼트입니다 :)',
            style: getTextTheme(context).regular.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).colorGray500,
                  height: 1.44,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: PrimaryFilledButton.largeRound(
              onPressed: () {
                Navigator.push(
                  context,
                  nextSlideScreen(RoutingScreen.MakeCakeShape.route),
                );
              },
              content: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/imgs/icon_home_cake.svg",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '케이크 제작하기',
                    style: getTextTheme(context).semiBold.copyWith(
                          color: getColorScheme(context).white,
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
              isActivated: true,
            ),
          )
        ],
      ),
    );
  }
}
