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
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class MakeCakePaymentScreen extends StatelessWidget {
  const MakeCakePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "3단계 - 결제하기",
      ),
      body: SingleChildScrollView(
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
                  const _Recipient(),
                  _Contact(),
                  _Destination(),
                  _Memo()
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              height: 8,
              color: getColorScheme(context).colorGray100,
            ),
            _PaymentInfo(),
            _PaymentMethod(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: double.infinity,
              height: 8,
              color: getColorScheme(context).colorGray100,
            ),
            _CheckAndAgree(),
            _PaymentButton()
          ],
        ),
      ),
    );
  }
}

class _Recipient extends StatelessWidget {
  const _Recipient({super.key});

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
          const UnderLineTextField(
            maxLength: 9999,
            hint: "수령인을 입력해주세요",
          )
        ],
      ),
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact({super.key});

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
          const UnderLineTextField(
            maxLength: 9999,
            hint: "연락처를 입력해주세요",
          )
        ],
      ),
    );
  }
}

class _Destination extends StatelessWidget {
  const _Destination({super.key});

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
          const UnderLineTextField(
            maxLength: 9999,
            hint: "배송지를 입력해주세요",
          )
        ],
      ),
    );
  }
}

class _Memo extends StatelessWidget {
  const _Memo({super.key});

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
          const UnderLineTextField(
            maxLength: 9999,
            hint: "배송메모를 입력해주세요",
          )
        ],
      ),
    );
  }
}

class _PaymentInfo extends StatelessWidget {
  const _PaymentInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "사이즈 : 1호[10cm], 맛 : 초코 / 라즈베리, 데코레이션 : 쟝미",
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 10,
                              color: getColorScheme(context).colorGray500,
                            ),
                      ),
                    ],
                  ),
                  Text(
                    "18,000원",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              ),
              SizedBox(
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
                    "3,000원",
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
  const _CheckAndAgree({super.key});

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

class _PaymentButton extends StatelessWidget {
  const _PaymentButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(24,8,24,80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryFilledButton.largeRect(
            onPressed: () async {
              Navigator.push(
                context,
                nextSlideScreen(
                  RoutingScreen.MakeCakeComplete.route,
                ),
              );
            },
            content: Text(
              "결제하기",
              style: getTextTheme(context).semiBold.copyWith(
                fontSize: 16,
                color: getColorScheme(context).white,
              ),
            ),
            isActivated: true,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: Text(
              "(주)오롯코드ㅣ서울특별시 마포구 월드컵북로5가길 22 (맥심빌딩, 3층)\n사업자등록번호 : 370-81-02809ㅣTEL. 070-4177-9333(고객센터)\n통신판매업신고번호 : 제0000-서울강남-00000호",
              style: getTextTheme(context).medium.copyWith(
                  fontSize: 10,
                  color: getColorScheme(context).colorGray500,
                  height: 1.8
              ),
            ),
          ),
        ],
      ),
    );
  }
}
