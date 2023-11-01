import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarTitle.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../navigation/PageMoveUtil.dart';
import '../../components/toast/Toast.dart';
import '../../model/UiState.dart';
import '../main/mypage/provider/LeaveAccountProvider.dart';
import '../sign_in/provider/MeInfoProvider.dart';

class WithdrawalScreen extends HookConsumerWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveState = ref.watch(leaveAccountProvider);
    final leaveManager = ref.read(leaveAccountProvider.notifier);
    final meInfoManager = ref.read(meInfoProvider.notifier);

    final agreeCheck = useState(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        leaveState.when(
          success: (event) async {
            leaveManager.init();
            meInfoManager.updateMeInfo(null);
            Toast.showSuccess(context, "회원탈퇴가 완료되었습니다");
            Navigator.pushAndRemoveUntil(
              context,
              nextFadeInOutScreen(RoutingScreen.SignIn.route),
                  (route) => false,
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [leaveState]);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "탈퇴하기",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "탈퇴 전 확인 사항 안내",
                      style: getTextTheme(context).semiBold.copyWith(
                            fontSize: 24,
                            color: getColorScheme(context).black,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text(
                        "메이크모먼트 탈퇴 전 확인해주세요",
                        style: getTextTheme(context).medium.copyWith(
                              fontSize: 16,
                              color: getColorScheme(context).black,
                            ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 16),
                      child: Text(
                        "· 메이크모먼트에서의 모든 정보를 볼 수 없습니다.\n· 기존의 결제내역 및 주문내역이 사라집니다.\n· 탈퇴 후 모든 데이터는 복구가 불가능합니다.",
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 14,
                              color: getColorScheme(context).colorGray500,
                              height: 2,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (leaveState is Loading) const LoadingView()
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(24, 24, 24, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Clickable(
                onPressed: () => agreeCheck.value = !agreeCheck.value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: IgnorePointer(
                    child: BasicBorderCheckBox(
                      isChecked: agreeCheck.value,
                      onChange: (value) => agreeCheck.value = value,
                      label: "안내사항을 모두 확인했으며, 이에 동의합니다.",
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 16),
                child: PrimaryFilledButton.largeRect(
                  content: Text(
                    "탈퇴하기",
                    style: getTextTheme(context).semiBold.copyWith(
                          fontSize: 16,
                          color: getColorScheme(context).white,
                        ),
                  ),
                  isActivated: agreeCheck.value ,
                  onPressed: (){
                    leaveManager.requestMeLeave();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}