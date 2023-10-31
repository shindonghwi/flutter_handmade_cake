import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class MakeCakeCompleteScreen extends StatelessWidget {
  const MakeCakeCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Center(
        child: Column(
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
              '케이크 주문 완료',
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
              '고객님의 행복한 순간을 위하여\n빠른 시일내에 케이크를 제작해 연락드리겠습니다',
              style: getTextTheme(context)
                  .regular
                  .copyWith(fontSize: 14, color: getColorScheme(context).colorGray500, height: 1.6),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: PrimaryFilledButton.largeRound(
            content: Text(
              "홈으로 이동하기",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 16,
                    color: getColorScheme(context).white,
                  ),
            ),
            isActivated: true,
            onPressed: (){
              Navigator.pushAndRemoveUntil(
                context,
                nextSlideScreen(RoutingScreen.Main.route),
                    (route) => false,
              );
            },
          ),
        ),
      ),
    );
  }
}
