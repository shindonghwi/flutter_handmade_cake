import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';

import '../../utils/Common.dart';

class FailView extends HookWidget {
  final VoidCallback onPressed;

  const FailView({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              getAppLocalizations(context).message_server_error_5xx,
              style: getTextTheme(context).medium.copyWith(
                    fontSize: 15,
                    color: getColorScheme(context).colorGray500,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            PrimaryFilledButton.largeRound(
              leftIcon: SvgPicture.asset(
                "assets/imgs/icon_refresh.svg",
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).white,
                  BlendMode.srcIn,
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  "재시도하기!",
                  style: getTextTheme(context).bold.copyWith(
                        fontSize: 15,
                        color: getColorScheme(context).white,
                      ),
                ),
              ),
              isActivated: true,
              onPressed: () => onPressed.call(),
            )
          ],
        ),
      ),
    );
  }
}
