import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/RegUtil.dart';

class UnderLineTextField extends HookWidget {
  final TextEditingController? controller;
  final int maxLength;
  final FocusNode focusNode;
  final String hint;
  final String successMessage;
  final String errorMessage;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final bool showPwVisibleButton;
  final bool forceErrorCheck;
  final bool enable;
  final List<RegCheckType> checkRegList;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onNextAction;
  final Function(String)? onChanged;

  const UnderLineTextField({
    Key? key,
    this.controller,
    required this.focusNode,
    required this.maxLength,
    required this.hint,
    this.successMessage = '',
    this.errorMessage = '',
    this.showPwVisibleButton = false,
    this.forceErrorCheck = false,
    this.enable = true,
    this.textInputType = TextInputType.text,
    this.checkRegList = const [],
    this.textInputAction = TextInputAction.next,
    this.inputFormatters = const [],
    this.onNextAction,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = this.controller ?? useTextEditingController();

    final isSuccess = useState<bool?>(null);
    final isPwVisible = useState(false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: (text) {
            for (var element in checkRegList) {
              if (element == RegCheckType.Email) {
                isSuccess.value = RegUtil.checkEmail(text);
              }
              if (element == RegCheckType.PW) {
                isSuccess.value = RegUtil.checkPw(text);
              }
              if (element == RegCheckType.Nickname) {
                isSuccess.value = RegUtil.checkNickname(text);
              }
            }

            if (isSuccess.value == false && forceErrorCheck) {
              isSuccess.value = forceErrorCheck;
            }

            onChanged?.call(text);
          },
          inputFormatters: inputFormatters,
          obscureText: isPwVisible.value ? false : textInputType == TextInputType.visiblePassword,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          style: getTextTheme(context).regular.copyWith(
                color: getColorScheme(context).black,
                fontSize: 14,
              ),
          onSubmitted: (text) {
            if (textInputAction == TextInputAction.next) {
              onNextAction?.call();
            } else if (textInputAction == TextInputAction.done) {
              FocusScope.of(context).unfocus();
            }
          },
          enabled: enable,
          maxLength: maxLength,
          decoration: InputDecoration(
            isCollapsed: true,
            hintText: hint,
            hintStyle: getTextTheme(context).regular.copyWith(
                  color: getColorScheme(context).colorGray300,
                  fontSize: 14,
                ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGray300
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorError500
                        : getColorScheme(context).colorGray300,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorGray300
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorError500
                        : getColorScheme(context).colorGray300,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: isSuccess.value == true && successMessage.isNotEmpty
                    ? getColorScheme(context).colorPrimary500
                    : (forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty
                        ? getColorScheme(context).colorError500
                        : getColorScheme(context).colorGray300,
                width: 1.0, // Adjust the width as needed
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 4,
            ),
            suffixIconConstraints: const BoxConstraints(minHeight: 20, minWidth: 20),
            counter: null,
            counterText: '',
            suffixIcon: Container(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showPwVisibleButton)
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => isPwVisible.value = !isPwVisible.value,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SvgPicture.asset(
                              isPwVisible.value == true
                                  ? "assets/imgs/icon_view.svg"
                                  : "assets/imgs/icon_view_hide.svg",
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                getColorScheme(context).colorGray500,
                                BlendMode.srcIn,
                              )),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        if (isSuccess.value == true && successMessage.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.check, color: Colors.green, size: 14),
              ),
              Text(
                successMessage.toString(),
                style:
                    getTextTheme(context).medium.copyWith(color: getColorScheme(context).colorPrimary500, fontSize: 12),
              ),
            ],
          ),
        if ((forceErrorCheck || isSuccess.value == false) && errorMessage.isNotEmpty)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.error, color: Colors.red, size: 14),
              ),
              Text(
                errorMessage.toString(),
                style:
                    getTextTheme(context).medium.copyWith(color: getColorScheme(context).colorError500, fontSize: 12),
              ),
            ],
          ),
      ],
    );
  }
}
