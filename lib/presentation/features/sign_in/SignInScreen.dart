import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/RegUtil.dart';

class SignInScreen extends HookWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useScrollController();
    final emailText = useState('');
    final pwText = useState('');

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: SingleChildScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 140.0),
                  child: SvgPicture.asset(
                    "assets/imgs/image_signin_logo.svg",
                    width: 100,
                    height: 100,
                  ),
                ),
                const SizedBox(
                  height: 120,
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
                // const SizedBox(height: 8),
                SizedBox(
                  height: 72,
                  child: UnderLineTextField(
                    maxLength: 9999,
                    hint: "비밀번호를 입력해주세요",
                    textInputType: TextInputType.visiblePassword,
                    showPwVisibleButton: true,
                    onChanged: (text) => pwText.value = text,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  child: PrimaryFilledButton.normalRect(
                    isActivated: true,
                    onPressed: () {},
                    content: '로그인',
                  ),
                ),
                const SizedBox(height: 12),
                Clickable(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                        text: TextSpan(
                            text: "아직 회원이 아니신가요? ",
                            style: getTextTheme(context).medium.copyWith(
                                  color: getColorScheme(context).colorGray500,
                                  fontSize: 14,
                                ),
                            children: [
                              TextSpan(
                                text: "회원가입",
                                style: getTextTheme(context).medium.copyWith(
                                      color: getColorScheme(context).colorGray500,
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                    ),
                              )
                            ]),
                      ),
                    ),
                    onPressed: () {})
              ],
            ),
          ),
        ),
      ),
    );
  }
}
