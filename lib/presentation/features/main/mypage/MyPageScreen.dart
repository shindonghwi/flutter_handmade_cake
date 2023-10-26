import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarTitle.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/features/sign_in/provider/MeInfoProvider.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'provider/LogoutProvider.dart';

class MyPageScreen extends HookConsumerWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shippingNotification = useState(true);

    final logoutState = ref.watch(logoutProvider);
    final logoutManager = ref.read(logoutProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);

    void goToLogin() {
      meInfoManager.updateMeInfo(null);
      Navigator.pushAndRemoveUntil(
        context,
        nextFadeInOutScreen(RoutingScreen.SignIn.route),
        (route) => false,
      );
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        logoutState.when(
          success: (event) async {
            logoutManager.init();
            goToLogin();
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [logoutState]);

    return BaseScaffold(
        backgroundColor: getColorScheme(context).white,
        appBar: const TopBarTitle(
          content: "내 정보",
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "이메일 주소",
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Text(
                            meInfoManager.getInfo()?.email ?? "",
                            style: getTextTheme(context).regular.copyWith(
                                  fontSize: 14,
                                  color: getColorScheme(context).colorGray500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    margin: const EdgeInsets.only(top: 12),
                    color: getColorScheme(context).colorGray100,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            "알림",
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "케이크 배송 알림",
                                style: getTextTheme(context).regular.copyWith(
                                      fontSize: 14,
                                      color: getColorScheme(context).black,
                                    ),
                              ),
                              Switch.adaptive(
                                activeColor: getColorScheme(context).colorPrimary500,
                                inactiveTrackColor: getColorScheme(context).colorGray300,
                                value: shippingNotification.value,
                                onChanged: (value) => shippingNotification.value = value,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16.0),
                          child: Text(
                            "회원정보",
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Clickable(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('로그아웃'),
                                  content: Text('정말로 로그아웃 하시겠습니까?'),
                                  actions: <Widget>[
                                    Clickable(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          '취소',
                                          style: getTextTheme(context).medium.copyWith(
                                                color: getColorScheme(context).colorGray500,
                                              ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    Clickable(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Text(
                                          '로그아웃',
                                          style: getTextTheme(context).medium.copyWith(
                                                color: getColorScheme(context).colorPrimary500,
                                              ),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        logoutManager.requestLogout();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "로그아웃",
                              style: getTextTheme(context).regular.copyWith(
                                    fontSize: 14,
                                    color: getColorScheme(context).black,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16, top: 16.0),
                          child: Text(
                            "관리",
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Clickable(
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              "탈퇴하기",
                              style: getTextTheme(context).semiBold.copyWith(
                                    fontSize: 12,
                                    color: getColorScheme(context).colorGray500,
                                    decoration: TextDecoration.underline,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (logoutState is Loading) const LoadingView(),
          ],
        ));
  }
}
