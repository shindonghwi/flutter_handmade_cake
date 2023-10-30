import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/CakeCanvas.dart';
import 'widgets/ContentCakeDecoration.dart';
import 'widgets/ContentCakeOption.dart';
import 'widgets/tabs/ContentCakeFiling.dart';
import 'widgets/tabs/ContentCakeFlavor.dart';
import 'widgets/tabs/ContentCakeSheet.dart';
import 'widgets/tabs/ContentCakeSize.dart';

GlobalKey canvasGlobalKey = GlobalKey();
final scrollProvider = StateProvider<bool>((_) => true); // true means scrolling is allowed

class MakeCakeDrawingScreen extends HookConsumerWidget {
  const MakeCakeDrawingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allowScroll = ref.watch(scrollProvider);
    final tabList = ["시트", "", "필링잼", "사이즈"];

    final tabController = useTabController(initialLength: tabList.length);

    Future<Uint8List> captureImage() async {
      double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      RenderRepaintBoundary boundary = canvasGlobalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData!.buffer.asUint8List();
    }

    final scrollController = useScrollController();

    return BaseScaffold(
      isCanvasMode: true,
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "1단계 - 케이크 제작",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: allowScroll ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(),
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
                    ContentCakeDecoration()
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
              Toast.showSuccess(context, "이미지가 합성되었습니다");
              captureImage();
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
