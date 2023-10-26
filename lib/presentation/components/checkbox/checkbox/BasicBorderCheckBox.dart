import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class BasicBorderCheckBox extends StatelessWidget {
  final String label;
  final bool isChecked;
  final double borderRadius;
  final TextStyle? textStyle;
  final Function(bool)? onChange;

  const BasicBorderCheckBox({
    super.key,
    this.label = "",
    this.borderRadius = 100,
    this.textStyle,
    required this.isChecked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    void toggleCheckbox() {
      onChange?.call(!isChecked);
    }

    return GestureDetector(
      onTap: toggleCheckbox,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isChecked ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray200,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                "assets/imgs/icon_check_line.svg",
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  getColorScheme(context).white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          if (label.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                label,
                style: textStyle ??
                    getTextTheme(context).medium.copyWith(
                          color: getColorScheme(context).colorGray500,
                        ),
              ),
            ),
        ],
      ),
    );
  }
}
