import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/checkbox/checkbox/BasicBorderCheckBox.dart';
import 'package:handmade_cake/presentation/components/checkbox/radio/BasicBorderRadioButton.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/RegisterCakeImageProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/MakeCakeDrawingScreen.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/CakeFilingProvider.dart';
import '../provider/CakeFlavorProvider.dart';
import '../provider/CakeIndentProvider.dart';
import '../provider/CakeSizeProvider.dart';

class MakeCakePaymentScreen extends HookConsumerWidget {
  const MakeCakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeOrderState = ref.watch(requestOrderProvider);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);
    final cakeOrderManager = ref.read(requestOrderProvider.notifier);
    final recipient = useState<String>("");
    final contact = useState<String>("");
    final destination = useState<String>("");
    final memo = useState<String>("");

    final recipientFocusNode = useFocusNode();
    final contactFocusNode = useFocusNode();
    final destinationFocusNode = useFocusNode();
    final memoFocusNode = useFocusNode();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        cakeIndentManager.updatePrice(cakeIndentManager.getTotalPrice());
      });
      return () {
        Future(() {
          cakeIndentManager.init();
          cakeOrderManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        cakeOrderState.when(
          success: (event) async {
            Navigator.push(
              context,
              nextSlideScreen(
                RoutingScreen.PaymentWebView.route,
                parameter: "https://appapi.make-moment.com/"
                    "v1/web/payment?orderId=${event.value.toString()}&paymentMethod=CARD",
              ),
            );
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [cakeOrderState]);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "3단계 - 결제하기",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "결제하기",
                          style: getTextTheme(context).semiBold.copyWith(
                                fontSize: 24,
                                color: getColorScheme(context).black,
                              ),
                        ),
                      ),
                      _Recipient(
                        focusNode: recipientFocusNode,
                        onNextAction: () {
                          contactFocusNode.requestFocus();
                        },
                        onChanged: (text) {
                          cakeIndentManager.updateReceiverName(text);
                          recipient.value = text;
                        },
                      ),
                      _Contact(
                        focusNode: contactFocusNode,
                        onNextAction: (){
                          destinationFocusNode.requestFocus();
                        },
                        onChanged: (text) {
                          cakeIndentManager.updateReceiverPhone(text);
                          contact.value = text;
                        },
                      ),
                      _Destination(
                        focusNode: destinationFocusNode,
                        onNextAction: (){
                          memoFocusNode.requestFocus();
                        },
                        onChanged: (text) {
                          cakeIndentManager.updateReceiverAddress(text);
                          destination.value = text;
                        },
                      ),
                      _Memo(
                        focusNode: memoFocusNode,
                        onChanged: (text) {
                          cakeIndentManager.updateMemo(text);
                          memo.value = text;
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  height: 8,
                  color: getColorScheme(context).colorGray100,
                ),
                const _PaymentInfo(),
                const _PaymentMethod(),
                _PaymentButton(
                  isActivated: recipient.value.isNotEmpty && contact.value.isNotEmpty && destination.value.isNotEmpty,
                )
              ],
            ),
          ),
          if (cakeOrderState is Loading) LoadingView()
        ],
      ),
    );
  }
}

class _Recipient extends StatelessWidget {
  final FocusNode focusNode;
  final Function() onNextAction;
  final Function(String) onChanged;

  const _Recipient({
    super.key,
    required this.focusNode,
    required this.onNextAction,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "수령인",
            style: getTextTheme(context).medium.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          UnderLineTextField(
            focusNode: focusNode,
            maxLength: 9999,
            hint: "수령인을 입력해주세요",
            onChanged: (value) => onChanged.call(value),
            onNextAction: () => onNextAction.call(),
          )
        ],
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  final FocusNode focusNode;
  final Function() onNextAction;
  final Function(String) onChanged;

  const _Contact({
    super.key,
    required this.focusNode,
    required this.onNextAction,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "연락처",
            style: getTextTheme(context).medium.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          UnderLineTextField(
            focusNode: focusNode,
            maxLength: 9999,
            textInputType: TextInputType.phone,
            hint: "연락처를 입력해주세요",
            onChanged: (value) => onChanged.call(value),
            onNextAction: () => onNextAction.call(),
          )
        ],
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  final FocusNode focusNode;
  final Function() onNextAction;
  final Function(String) onChanged;

  const _Destination({
    super.key,
    required this.focusNode,
    required this.onNextAction,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "배송지",
            style: getTextTheme(context).medium.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          UnderLineTextField(
            focusNode: focusNode,
            maxLength: 9999,
            hint: "배송지를 입력해주세요",
            onChanged: (value) => onChanged.call(value),
            onNextAction: () => onNextAction.call(),
          )
        ],
      ),
    );
  }
}

class _Memo extends StatelessWidget {
  final FocusNode focusNode;
  final Function(String) onChanged;

  const _Memo({
    super.key,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "배송 메모",
            style: getTextTheme(context).medium.copyWith(
                  fontSize: 14,
                  color: getColorScheme(context).colorGray500,
                ),
          ),
          const SizedBox(
            height: 8,
          ),
          UnderLineTextField(
            focusNode: focusNode,
            maxLength: 9999,
            hint: "배송메모를 입력해주세요",
            textInputAction: TextInputAction.done,
            onChanged: (value) => onChanged.call(value),
          )
        ],
      ),
    );
  }
}

class _PaymentInfo extends HookConsumerWidget {
  const _PaymentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeFlavor = ref.watch(cakeFlavorProvider);
    final cakeFiling = ref.watch(cakeFilingProvider);
    final cakeSize = ref.watch(cakeSizeProvider);

    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: Text(
              "결제내역",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 18,
                    color: getColorScheme(context).black,
                  ),
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "케이크 금액",
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 14,
                              color: getColorScheme(context).black,
                            ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "사이즈: ${cakeSize.sizeType}, 맛: ${cakeFlavor.flavorType} / ${cakeFiling.filingType}\n데코레이션: ${cakeIndentManager.getDecorations().join(", ")}",
                        style: getTextTheme(context)
                            .regular
                            .copyWith(fontSize: 10, color: getColorScheme(context).colorGray500, height: 1.4),
                      ),
                    ],
                  ),
                  Text(
                    "${cakeIndentManager.getPrice()}원",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "배송비",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                  Text(
                    "4,900원",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _PaymentMethod extends HookWidget {
  const _PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Text(
              "결제방식",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 18,
                    color: getColorScheme(context).black,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: IgnorePointer(
              child: BasicBorderRadioButton(
                isChecked: true,
                label: "신용카드",
                onChange: (value) {},
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CheckAndAgree extends HookWidget {
  final Function(bool) onAgreed;

  const _CheckAndAgree({
    super.key,
    required this.onAgreed,
  });

  @override
  Widget build(BuildContext context) {
    final allAgree = useState<bool>(false);
    final isAgree1 = useState<bool>(false);
    final isAgree2 = useState<bool>(false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Clickable(
            onPressed: () {
              allAgree.value = !allAgree.value;
              isAgree1.value = allAgree.value;
              isAgree2.value = allAgree.value;
              onAgreed.call(allAgree.value);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: IgnorePointer(
                child: BasicBorderCheckBox(
                  isChecked: allAgree.value,
                  onChange: (value) {},
                  label: "주문내용 확인 및 결제 동의",
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Clickable(
                onPressed: () {
                  isAgree1.value = !isAgree1.value;
                  if (isAgree1.value && isAgree2.value) {
                    allAgree.value = true;
                  } else {
                    allAgree.value = false;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_check_line.svg",
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          isAgree1.value
                              ? getColorScheme(context).colorPrimary500
                              : getColorScheme(context).colorGray500,
                          BlendMode.srcIn,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "개인정보 제3자 정보 제공 동의",
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 10,
                                color: getColorScheme(context).colorPrimary500,
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Clickable(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    "자세히보기",
                    style: getTextTheme(context).medium.copyWith(
                          fontSize: 10,
                          color: getColorScheme(context).colorPrimary500,
                        ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Clickable(
                onPressed: () {
                  isAgree2.value = !isAgree2.value;
                  if (isAgree2.value && isAgree2.value) {
                    allAgree.value = true;
                  } else {
                    allAgree.value = false;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/imgs/icon_check_line.svg",
                        width: 16,
                        height: 16,
                        colorFilter: ColorFilter.mode(
                          isAgree2.value
                              ? getColorScheme(context).colorPrimary500
                              : getColorScheme(context).colorGray500,
                          BlendMode.srcIn,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(
                          "결제대행 서비스 이용약관 동의",
                          style: getTextTheme(context).medium.copyWith(
                                fontSize: 10,
                                color: getColorScheme(context).colorPrimary500,
                              ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Clickable(
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    "자세히보기",
                    style: getTextTheme(context).medium.copyWith(
                          fontSize: 10,
                          color: getColorScheme(context).colorPrimary500,
                        ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _PaymentButton extends HookConsumerWidget {
  final bool isActivated;

  const _PaymentButton({
    super.key,
    required this.isActivated,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeImagePathState = ref.watch(cakeImagePath);
    final cakeIndentState = ref.watch(cakeIndentProvider);
    final cakeOrderManager = ref.read(requestOrderProvider.notifier);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24, 8, 24, 80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryFilledButton.largeRect(
            onPressed: () async {
              cakeOrderManager.requestOrder(cakeImagePathState.toString(), cakeIndentState);
            },
            content: Text(
              "결제하기",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 16,
                    color: getColorScheme(context).white,
                  ),
            ),
            isActivated: isActivated,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              "(주)오롯코드ㅣ서울특별시 마포구 월드컵북로5가길 22 (맥심빌딩, 3층)\n사업자등록번호 : 370-81-02809ㅣTEL. 070-4177-9333(고객센터)\n통신판매업신고번호 : 제0000-서울강남-00000호",
              style: getTextTheme(context)
                  .medium
                  .copyWith(fontSize: 10, color: getColorScheme(context).colorGray500, height: 1.8),
            ),
          ),
        ],
      ),
    );
  }
}
