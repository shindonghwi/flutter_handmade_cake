import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class PrimaryFilledButton extends HookWidget {
  final Widget? leftIcon;
  final Widget content;
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

  const PrimaryFilledButton.largeRect({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 10,
        height = 56,
        super(key: key);

  const PrimaryFilledButton.largeRound({
    Key? key,
    this.leftIcon,
    required this.content,
    required this.isActivated,
    this.onPressed,
  })  : borderRadius = 100,
        height = 56,
        super(key: key);


  @override
  Widget build(BuildContext context) {
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
            content,
          ],
        ),
      ),
    );
  }
}
