import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/dto/Pair.dart';

class MakeCakeShapeScreen extends HookWidget {
  const MakeCakeShapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(-1);
    final scrollController = useScrollController();

    final List<Pair> items = [
      Pair("assets/imgs/icon_rect.svg", "사각형 모양 케이크"),
      Pair("assets/imgs/icon_circle.svg", "원형 모양 케이크"),
      Pair("assets/imgs/icon_heart.svg", "하트 모양 케이크"),
      Pair("assets/imgs/icon_octagon.svg", "팔각형 모양 케이크"),
    ];

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: TopBarIconTitleText(
        content: "1단계 - 모양 선택하기",
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(24.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
              ),
              controller: scrollController,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];

                return Clickable(
                  onPressed: () {
                    selectedIndex.value = index;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: getColorScheme(context).colorGray300,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            item.first,
                            width: 40,
                            height: 40,
                            colorFilter: ColorFilter.mode(
                              selectedIndex.value == index
                                  ? getColorScheme(context).colorPrimary900
                                  : getColorScheme(context).colorGray300,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            item.second,
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 14,
                                  color: selectedIndex.value == index
                                      ? getColorScheme(context).colorPrimary900
                                      : getColorScheme(context).colorGray300,
                                ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: PrimaryFilledButton.largeRect(
            content: Text(
              "다음",
              style: getTextTheme(context).semiBold.copyWith(
                    fontSize: 16,
                    color: getColorScheme(context).white,
                  ),
            ),
            isActivated: selectedIndex.value != -1,
          ),
        ),
      ),
    );
  }
}
