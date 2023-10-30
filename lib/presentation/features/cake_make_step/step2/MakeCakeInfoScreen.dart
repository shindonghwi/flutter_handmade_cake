import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/textfield/OutLineTextField.dart';
import 'package:handmade_cake/presentation/components/textfield/UnderLineTextField.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/widgets/ContentCakeOption.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class MakeCakeInfoScreen extends HookWidget {
  final String? imagePath;

  const MakeCakeInfoScreen({
    super.key,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "2단계 - 케이크 정보 작성",
      ),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 342 / 260,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: CollectionUtil.isNullEmptyFromString(imagePath)
                      ? const Placeholder()
                      : Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const _CakeInfo(),
              const _CakePurpose(),
              const _CakeRequestTerm(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: PrimaryFilledButton.largeRect(
            onPressed: () async {
              Navigator.push(
                context,
                nextSlideScreen(
                  RoutingScreen.MakeCakePayment.route,
                ),
              );
            },
            content: Text(
              "다음",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 16,
                    color: getColorScheme(context).white,
                  ),
            ),
            isActivated: true,
          ),
        ),
      ),
    );
  }
}

class _CakeInfo extends HookWidget {
  const _CakeInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 32,
        ),
        Text(
          "케이크 정보",
          style: getTextTheme(context).medium.copyWith(
                fontSize: 14,
                color: getColorScheme(context).colorGray500,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        const ContentCakeOption()
      ],
    );
  }
}

class _CakePurpose extends HookWidget {
  const _CakePurpose({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "어떤 이유로 케이크를 만드시나요?",
          style: getTextTheme(context).medium.copyWith(
                fontSize: 14,
                color: getColorScheme(context).colorGray500,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        OutLineTextField(
          maxLength: 9999,
          hint: "예) 생일, 결혼식, 출산, 친구 선물 등",
          textInputAction: TextInputAction.next,
          onChanged: (text) {},
        ),
      ],
    );
  }
}

class _CakeRequestTerm extends HookWidget {
  const _CakeRequestTerm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          "추가 요청사항을 적어주세요",
          style: getTextTheme(context).medium.copyWith(
                fontSize: 14,
                color: getColorScheme(context).colorGray500,
              ),
        ),
        const SizedBox(
          height: 12,
        ),
        OutLineTextField(
          maxLength: 9999,
          maxLines: 5,
          hint: "예) 색상, 테마, 특이사항 등",
          textInputAction: TextInputAction.done,
          onChanged: (text) {},
        ),
      ],
    );
  }
}
