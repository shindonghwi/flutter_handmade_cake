import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class TopBarTitle extends HookWidget implements PreferredSizeWidget {
  final String content;

  const TopBarTitle({
    super.key,
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
        child: Align(
          alignment: Alignment.center,
          child: Text(
            content,
            style: getTextTheme(context).medium.copyWith(color: Colors.black, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
