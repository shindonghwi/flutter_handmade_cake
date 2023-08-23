import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarTitle.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class MyPageScreen extends HookWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shippingNotification = useState(true);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarTitle(
        content: "내 정보",
      ),
      body: SingleChildScrollView(
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
                            color: getColorScheme(context).colorGray500,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Text(
                      "test1234@makemoment.com",
                      style: getTextTheme(context).regular.copyWith(
                            fontSize: 14,
                            color: getColorScheme(context).black,
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
                            color: getColorScheme(context).colorGray500,
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
          ],
        ),
      ),
    );
  }
}
