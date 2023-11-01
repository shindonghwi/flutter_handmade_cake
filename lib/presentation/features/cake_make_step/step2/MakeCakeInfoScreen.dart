import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/textfield/OutLineTextField.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/MakeCakeDrawingScreen.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/widgets/ContentCakeOption.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../provider/CakeIndentProvider.dart';

class MakeCakeInfoScreen extends HookConsumerWidget {
  const MakeCakeInfoScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cakeImagePathState = ref.watch(cakeImagePath);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);

    var reason = useState("");
    var request = "";

    final memoFocusNode = useFocusNode();

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
                  child: CollectionUtil.isNullEmptyFromString(cakeImagePathState)
                      ? const Placeholder()
                      : Image.file(
                          File(cakeImagePathState!),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const _CakeInfo(),
              _CakePurpose(
                onChanged: (text) {
                  reason.value = text;
                },
                onNextAction: () {
                  memoFocusNode.requestFocus();
                },
              ),
              _CakeRequestTerm(
                focusNode: memoFocusNode,
                onChanged: (text) {
                  request = text;
                },
              ),
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
              cakeIndentManager.updateMessage(reason.value, request);
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
            isActivated: reason.value.isNotEmpty,
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
  final Function(String) onChanged;
  final Function() onNextAction;

  const _CakePurpose({
    super.key,
    required this.onNextAction,
    required this.onChanged,
  });

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
          focusNode: useFocusNode(),
          maxLength: 9999,
          hint: "예) 생일, 결혼식, 출산, 친구 선물 등",
          textInputAction: TextInputAction.next,
          onChanged: (text) => onChanged.call(text),
          onNextAction: () => onNextAction.call(),
        ),
      ],
    );
  }
}

class _CakeRequestTerm extends HookWidget {
  final FocusNode focusNode;
  final Function(String) onChanged;

  const _CakeRequestTerm({
    super.key,
    required this.focusNode,
    required this.onChanged,
  });

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
          focusNode: focusNode,
          maxLength: 9999,
          maxLines: 5,
          hint: "예) 색상, 테마, 특이사항 등",
          textInputAction: TextInputAction.done,
          onChanged: (text) => onChanged.call(text),
        ),
      ],
    );
  }
}
