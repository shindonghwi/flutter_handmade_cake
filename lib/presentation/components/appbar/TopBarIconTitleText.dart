import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class TopBarIconTitleText extends HookWidget implements PreferredSizeWidget {
  final String content;
  final String? leftIconPath;
  final String? rightText;
  final bool? rightTextActivated;
  final VoidCallback? leftIconOnPressed;
  final VoidCallback? rightIconOnPressed;

  const TopBarIconTitleText({
    super.key,
    this.leftIconPath,
    this.rightText,
    this.rightTextActivated,
    this.leftIconOnPressed,
    this.rightIconOnPressed,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: getMediaQuery(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: getColorScheme(context).colorGray300,
              width: 1,
            ),
          ),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 48,
                height: 48,
                margin: const EdgeInsets.only(left: 12.0),
                child: Clickable(
                  onPressed: () {
                    leftIconOnPressed != null ? leftIconOnPressed?.call() : Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(leftIconPath ?? "assets/imgs/icon_back.svg", width: 24, height: 24),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                content,
                style: getTextTheme(context).medium.copyWith(color: Colors.black, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            if (rightText != null && rightTextActivated != null)
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 12.0),
                  child: Clickable(
                    onPressed: () => rightIconOnPressed?.call(),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        rightText ?? "",
                        style: getTextTheme(context).medium.copyWith(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
