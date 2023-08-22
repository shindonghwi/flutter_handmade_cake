import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/RegUtil.dart';

class SignUpScreen extends HookWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final emailText = useState('');
    final pw1Text = useState('');
    final pw2Text = useState('');

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleText(
        content: "회원가입",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  "회원가입",
                  style: getTextTheme(context).semiBold.copyWith(
                        fontSize: 24,
                        color: getColorScheme(context).black,
                      ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "메이크모먼트와 행복한 순간을 함께하세요",
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 14,
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  "이메일",
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 14,
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
                SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 72,
                  child: UnderLineTextField(
                    maxLength: 9999,
                    hint: "이메일을 입력해주세요",
                    successMessage: "올바른 이메일 형식입니다 :)",
                    errorMessage: "올바른 이메일 형식을 입력해주세요",
                    checkRegList: const [
                      RegCheckType.Email,
                    ],
                    onChanged: (text) => emailText.value = text,
                  ),
                ),
                Text(
                  "비밀번호",
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 14,
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
                SizedBox(
                  height: 68,
                  child: UnderLineTextField(
                    maxLength: 9999,
                    hint: "비밀번호를 입력해주세요",
                    successMessage: "올바른 비밀번호 형식입니다 :)",
                    errorMessage: "올바른 비밀번호 형식을 입력해주세요",
                    textInputType: TextInputType.visiblePassword,
                    showPwVisibleButton: true,
                    onChanged: (text) => pw1Text.value = text,
                  ),
                ),
                Text(
                  "비밀번호 확인",
                  style: getTextTheme(context).medium.copyWith(
                        fontSize: 14,
                        color: getColorScheme(context).colorGray500,
                      ),
                ),
                SizedBox(
                  height: 68,
                  child: UnderLineTextField(
                    maxLength: 9999,
                    hint: "비밀번호를 한번 더 입력해주세요",
                    successMessage: "비밀번호가 일치합니다 :)",
                    errorMessage: "비밀번호가 일치하지 않습니다",
                    textInputType: TextInputType.visiblePassword,
                    showPwVisibleButton: true,
                    onChanged: (text) => pw2Text.value = text,
                    textInputAction: TextInputAction.done,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 40),
                  width: double.infinity,
                  child: PrimaryFilledButton.normalRect(
                    content: "가입하기",
                    isActivated: RegUtil.checkEmail(emailText.value) &&
                        pw1Text.value.isNotEmpty &&
                        pw2Text.value.isNotEmpty &&
                        pw1Text.value == pw2Text.value,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
