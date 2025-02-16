import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/features/sign_in/provider/MeInfoProvider.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/RegUtil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/LoginProvider.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useScrollController();
    final emailText = useState('');
    final pwText = useState('');
    final loginState = ref.watch(loginProvider);
    final loginManager = ref.read(loginProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);

    useEffect(() {
      return () {
        Future(() {
          loginManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        loginState.when(
          success: (event) async {
            if (loginManager.meInfo != null) {
              meInfoManager.updateMeInfo(loginManager.meInfo);
            }
            Navigator.pushReplacement(
              context,
              nextFadeInOutScreen(RoutingScreen.Main.route),
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [loginState]);

    final emailFocusNode = useFocusNode();
    final pwFocusNode = useFocusNode();

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                      height: 68,
                      child: UnderLineTextField(
                        focusNode: emailFocusNode,
                        maxLength: 9999,
                        hint: "이메일을 입력해주세요",
                        successMessage: "올바른 이메일 형식입니다 :)",
                        errorMessage: "올바른 이메일 형식을 입력해주세요",
                        checkRegList: const [
                          RegCheckType.Email,
                        ],
                        onChanged: (text) {
                          loginManager.updateEmail(text);
                          emailText.value = text;
                        },
                        onNextAction: () => emailFocusNode.requestFocus(),
                      ),
                    ),
                    SizedBox(
                      height: 68,
                      child: UnderLineTextField(
                        focusNode: pwFocusNode,
                        maxLength: 9999,
                        hint: "비밀번호를 입력해주세요",
                        textInputType: TextInputType.visiblePassword,
                        showPwVisibleButton: true,
                        textInputAction: TextInputAction.done,
                        onChanged: (text) {
                          loginManager.updatePassword(text);
                          pwText.value = text;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: PrimaryFilledButton.normalRect(
                        content: Text(
                          '로그인',
                          style: getTextTheme(context).semiBold.copyWith(
                                color: getColorScheme(context).white,
                                fontSize: 16,
                              ),
                        ),
                        isActivated: RegUtil.checkEmail(emailText.value) && pwText.value.isNotEmpty,
                        onPressed: () {
                          loginManager.doEmailLogin();
                        },
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
                            ],
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          nextSlideScreen(RoutingScreen.SignUp.route),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    Clickable(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            text: "여기를 눌러 제작된 케이크를 먼저 구경해보세요!",
                            style: getTextTheme(context).medium.copyWith(
                                  color: getColorScheme(context).colorGray500,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline,
                                ),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          nextSlideScreen(RoutingScreen.SampleCake.route),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            if (loginState is Loading) const LoadingView()
          ],
        ),
      ),
    );
  }
}
