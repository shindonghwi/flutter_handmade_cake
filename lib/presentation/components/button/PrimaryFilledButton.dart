import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class PrimaryFilledButton extends HookWidget {
  final Widget? leftIcon;
  final String content;
  final bool isActivated;
  final Function()? onPressed;
  final double height;
  final double borderRadius;

  const PrimaryFilledButton.normalRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 52,
        super(key: key);


  @override
  Widget build(BuildContext context) {
    var textColor = getColorScheme(context).white;
    var textStyle = getTextTheme(context).semiBold.copyWith(color: textColor, fontSize: 16);

    switch (height) {
      case 52:
        textStyle = getTextTheme(context).semiBold.copyWith(color: textColor, fontSize: 16);
        break;
      case 60:
        textStyle = getTextTheme(context).semiBold.copyWith(color: textColor, fontSize: 16);
        break;
    }

    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: isActivated ? () => onPressed?.call() : null,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: getColorScheme(context).colorGray300,
          backgroundColor: isActivated ? getColorScheme(context).colorPrimary900 : getColorScheme(context).colorGray300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          ),
          elevation: 0,
          foregroundColor: getColorScheme(context).white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            leftIcon ?? Container(),
            Text(content, style: textStyle),
          ],
        ),
      ),
    );
  }
}
