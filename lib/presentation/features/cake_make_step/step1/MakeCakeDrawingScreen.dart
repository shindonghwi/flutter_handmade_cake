import 'dart:io';
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
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../components/canvas/ResizableImage.dart';
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
    final isLoading = useState(false);
    final allowScroll = ref.watch(scrollProvider);
    final focusedWidgetManager = ref.read(focusedWidgetProvider.notifier);
    final tabList = ["시트", "맛", "필링잼", "사이즈"];

    final tabController = useTabController(initialLength: tabList.length);

    Future<void> deleteCachedImages() async {
      Directory tempDir = await getTemporaryDirectory();
      List<FileSystemEntity> files = tempDir.listSync();

      for (FileSystemEntity file in files) {
        if (file.path.contains('cake_image')) {
          file.deleteSync();
        }
      }
    }

    Future<String?> captureImage() async {
      isLoading.value = true;
      focusedWidgetManager.state = null;
      await deleteCachedImages();
      await Future.delayed(const Duration(milliseconds: 1000));
      double pixelRatio = MediaQuery.of(context).devicePixelRatio;
      RenderRepaintBoundary boundary = canvasGlobalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData == null) return null;

      Uint8List uint8list = byteData.buffer.asUint8List();

      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      DateTime now = DateTime.now();
      String timestamp = "${now.year}${now.month}${now.day}_${now.hour}${now.minute}${now.second}${now.millisecond}";

      File file = File('$tempPath/cake_image_$timestamp.png');
      await file.writeAsBytes(uint8list);

      isLoading.value = false;
      return file.path;
    }

    return BaseScaffold(
      isCanvasMode: true,
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarIconTitleText(
        content: "1단계 - 케이크 제작",
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
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
                        const ContentCakeDecoration()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isLoading.value)
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    getColorScheme(context).colorPrimary500,
                  ),
                ),
              )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: PrimaryFilledButton.largeRect(
            onPressed: () async {
              final imagePath = await captureImage();

              if (CollectionUtil.isNullEmptyFromString(imagePath)) {
                Toast.showWarning(context, "케이크 이미지를 만들 수 없습니다");
              } else {
                Navigator.push(
                  context,
                  nextSlideScreen(
                    RoutingScreen.MakeCakeInfo.route,
                    parameter: imagePath,
                  ),
                );
              }
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
