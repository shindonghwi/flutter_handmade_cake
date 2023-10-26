import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/data/models/me/RequestMeJoinModel.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/features/sign_in/provider/MeInfoProvider.dart';
import 'package:handmade_cake/presentation/features/signup/provider/SignUpProvider.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/RegUtil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signUpState = ref.watch(signUpProvider);
    final signUpManager = ref.read(signUpProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);
    final controller = useScrollController();
    final emailText = useState('');
    final pw1Text = useState('');
    final pw2Text = useState('');

    final allAgree = useState(false);
    final agree1 = useState(false);
    final agree2 = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (agree1.value && agree2.value == true) {
          allAgree.value = true;
        } else {
          allAgree.value = false;
        }
      });
      return null;
    }, [agree1.value, agree2.value]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        signUpState.when(
          success: (event) async {
            signUpManager.init();
            if (signUpManager.meInfo != null) {
              meInfoManager.updateMeInfo(signUpManager.meInfo);
            }
            Navigator.pushAndRemoveUntil(
              context,
              nextFadeInOutScreen(RoutingScreen.Main.route),
              (route) => false,
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [signUpState]);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "회원가입",
      ),
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "회원가입",
                          style: getTextTheme(context).semiBold.copyWith(
                                fontSize: 24,
                                color: getColorScheme(context).black,
                              ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "메이크모먼트와 행복한 순간을 함께하세요",
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 14,
                                color: getColorScheme(context).colorGray500,
                              ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          "이메일",
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 14,
                                color: getColorScheme(context).colorGray500,
                              ),
                        ),
                        const SizedBox(
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
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: getColorScheme(context).colorGray100,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "약관동의",
                            style: getTextTheme(context).bold.copyWith(
                                  fontSize: 24,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                          child: Clickable(
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: BasicBorderCheckBox(
                                isChecked: allAgree.value,
                                onChange: (value) {
                                  allAgree.value = value;
                                  agree1.value = value;
                                  agree2.value = value;
                                },
                                label: "전체 동의합니다",
                                textStyle: getTextTheme(context).medium.copyWith(
                                      fontSize: 16,
                                      color: getColorScheme(context).black,
                                    ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 1,
                          color: getColorScheme(context).colorGray300,
                          margin: const EdgeInsets.fromLTRB(8, 4, 4, 4),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Clickable(
                              onPressed: () => agree1.value = !agree1.value,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: BasicBorderCheckBox(
                                  isChecked: agree1.value,
                                  onChange: (value) => agree1.value = value,
                                  label: "[필수] 메이크모먼트 이용약관 동의",
                                  textStyle: getTextTheme(context).medium.copyWith(
                                        fontSize: 14,
                                        color: getColorScheme(context).colorGray500,
                                      ),
                                ),
                              ),
                            ),
                            Clickable(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/imgs/icon_next.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    getColorScheme(context).colorGray500,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Clickable(
                              onPressed: () => agree1.value = !agree1.value,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                child: BasicBorderCheckBox(
                                  isChecked: agree2.value,
                                  onChange: (value) => agree2.value = value,
                                  label: "[필수] 개인정보 수집 및 이용에 동의",
                                  textStyle: getTextTheme(context).medium.copyWith(
                                        fontSize: 14,
                                        color: getColorScheme(context).colorGray500,
                                      ),
                                ),
                              ),
                            ),
                            Clickable(
                              onPressed: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                  "assets/imgs/icon_next.svg",
                                  width: 20,
                                  height: 20,
                                  colorFilter: ColorFilter.mode(
                                    getColorScheme(context).colorGray500,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(8, 32, 8, 40),
                          width: double.infinity,
                          child: PrimaryFilledButton.normalRect(
                            content: Text(
                              '가입하기',
                              style: getTextTheme(context).semiBold.copyWith(
                                    color: getColorScheme(context).white,
                                    fontSize: 16,
                                  ),
                            ),
                            isActivated: RegUtil.checkEmail(emailText.value) &&
                                pw1Text.value.isNotEmpty &&
                                pw2Text.value.isNotEmpty &&
                                pw1Text.value == pw2Text.value &&
                                allAgree.value == true &&
                                agree1.value == true &&
                                agree2.value == true,
                            onPressed: () {
                              signUpManager.requestMeJoin(
                                RequestMeJoinModel(
                                  email: emailText.value,
                                  password: pw2Text.value,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          if (signUpState is Loading) const LoadingView()
        ],
      )),
    );
  }
}
