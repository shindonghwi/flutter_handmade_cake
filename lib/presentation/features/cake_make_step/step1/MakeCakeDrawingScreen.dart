import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

import 'widgets/CakeCanvas.dart';
import 'widgets/ContentCakeDecoration.dart';
import 'widgets/ContentCakeOption.dart';
import 'widgets/tabs/ContentCakeFiling.dart';
import 'widgets/tabs/ContentCakeFlavor.dart';
import 'widgets/tabs/ContentCakeSheet.dart';
import 'widgets/tabs/ContentCakeSize.dart';

class MakeCakeDrawingScreen extends HookWidget {
  const MakeCakeDrawingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabList = [
      "시트",
      "색상",
      "필링잼",
      "사이즈",
    ];

    final tabController = useTabController(initialLength: tabList.length);

    return BaseScaffold(
      isCanvasMode: true,
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "1단계 - 케이크 제작",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                TabBar(
                  controller: tabController,
                  indicatorColor: getColorScheme(context).colorPrimary500,
                  labelColor: getColorScheme(context).colorPrimary500,
                  unselectedLabelColor: getColorScheme(context).colorGray300,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 1,
                      color: getColorScheme(context).colorPrimary500,
                    ),
                  ),
                  tabs: tabList
                      .map(
                        (name) => Container(
                          height: 53,
                          alignment: Alignment.center,
                          child: Text(
                            name,
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 72,
                      child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: tabController,
                        children: const [
                          ContentCakeSheet(),
                          ContentCakeFlavor(),
                          ContentCakeFiling(),
                          ContentCakeSize(),
                        ],
                      ),
                    ),
                    const CakeCanvas(),
                    const ContentCakeOption(),
                    const ContentCakeDecoration(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: PrimaryFilledButton.largeRect(
            onPressed: () {
              Navigator.push(
                context,
                nextSlideScreen(RoutingScreen.MakeCakeInfo.route),
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
