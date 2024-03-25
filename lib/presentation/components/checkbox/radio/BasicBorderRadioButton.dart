import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class BasicBorderRadioButton extends StatelessWidget {
  final String label;
  final bool isChecked;
  final double size;
  final Function(bool)? onChange;

  const BasicBorderRadioButton({
    super.key,
    required this.isChecked,
    required this.onChange,
    this.label = '',
    this.size = 24.0,
  });

  @override
  Widget build(BuildContext context) {
    void toggleCheckbox() {
      onChange?.call(!isChecked);
    }

    return GestureDetector(
      onTap: toggleCheckbox,
      child: Row(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              border: Border.all(
                color: isChecked ? getColorScheme(context).colorPrimary500 : getColorScheme(context).colorGray300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: isChecked
                ? Center(
                    child: Container(
                      width: size * 0.75,
                      height: size * 0.75,
                      decoration: BoxDecoration(
                        color: getColorScheme(context).colorPrimary500,
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  )
                : Container(),
          ),
          if (!CollectionUtil.isNullEmptyFromString(label))
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                label,
                style: getTextTheme(context).regular.copyWith(
                      fontSize: 14,
                      color: getColorScheme(context).black,
                    ),
              ),
            )
        ],
      ),
    );
  }
}
