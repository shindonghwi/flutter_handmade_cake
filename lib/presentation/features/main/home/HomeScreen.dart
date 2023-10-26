import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/features/main/home/widgets/FirstTab.dart';
import 'package:handmade_cake/presentation/features/main/home/widgets/SecondTab.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabList = [
      "케이크 제작하기",
      "케이크 구경하기",
    ];

    final tabController = useTabController(initialLength: tabList.length);

    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 133,
            height: 33,
            child: SvgPicture.asset("assets/imgs/image_home_appbar.svg"),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: getColorScheme(context).colorGray300,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
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
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: const [
              FirstTab(),
              SecondTab(),
            ],
          ),
        ),
      ],
    );
  }
}
