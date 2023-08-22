import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/features/main/home/HomeScreen.dart';
import 'package:handmade_cake/presentation/features/main/mypage/MyPageScreen.dart';
import 'package:handmade_cake/presentation/features/main/orders/OrdersScreen.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:handmade_cake/presentation/utils/dto/Pair.dart';

class MainScreen extends HookWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final currentIndex = useState(0);

    List<Pair> iconList = [
      Pair('assets/imgs/icon_home.svg', "홈"),
      Pair('assets/imgs/icon_menu.svg', "주문내역"),
      Pair('assets/imgs/icon_mypage.svg', "내 정보"),
    ];

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 133,
                height: 33,
                child: SvgPicture.asset("assets/imgs/image_home_appbar.svg"),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: currentIndex.value,
                children: const [
                  HomeScreen(),
                  OrdersScreen(),
                  MyPageScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: getColorScheme(context).colorGray300,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: getColorScheme(context).white,
          selectedItemColor: getColorScheme(context).colorPrimary900,
          unselectedItemColor: getColorScheme(context).colorGray300,
          currentIndex: currentIndex.value,
          onTap: (index) => currentIndex.value = index,
          items: iconList.map((data) {
            return BottomNavigationBarItem(
              icon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorGray300,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
              activeIcon: Column(
                children: [
                  SvgPicture.asset(
                    data.first,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      getColorScheme(context).colorPrimary900,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  )
                ],
              ),
              label: data.second,
            );
          }).toList(),
          selectedLabelStyle: getTextTheme(context).medium.copyWith(
                color: getColorScheme(context).colorPrimary900,
                fontSize: 12,
              ),
          unselectedLabelStyle: getTextTheme(context).medium.copyWith(
                color: getColorScheme(context).colorGray300,
                fontSize: 12,
              ),
        ),
      ),
    );
  }
}
