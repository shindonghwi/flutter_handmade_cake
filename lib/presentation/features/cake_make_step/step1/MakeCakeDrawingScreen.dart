import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/popup/CommonPopup.dart';
import 'package:handmade_cake/presentation/components/popup/PopupNotice.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeFilingProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeFlavorProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeSizeProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/step1/provider/NoticeProvider.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import '../../../components/canvas/ResizableImage.dart';
import '../provider/CakeIndentProvider.dart';
import '../provider/CanvasWidgetsProvider.dart';
import '../provider/RegisterCakeImageProvider.dart';
import 'widgets/CakeCanvas.dart';
import 'widgets/ContentCakeDecoration.dart';
import 'widgets/ContentCakeOption.dart';
import 'widgets/tabs/ContentCakeFiling.dart';
import 'widgets/tabs/ContentCakeFlavor.dart';
import 'widgets/tabs/ContentCakeSheet.dart';
import 'widgets/tabs/ContentCakeSize.dart';

GlobalKey canvasGlobalKey = GlobalKey();

final cakeImagePath = StateProvider<String?>((_) => null);

final scrollProvider = StateProvider<bool>((_) => true);

class MakeCakeDrawingScreen extends HookConsumerWidget {
  const MakeCakeDrawingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeState = ref.watch(noticeProvider);
    final noticeManager = ref.read(noticeProvider.notifier);
    final canvasWidgetsManager = ref.read(canvasWidgetsProvider.notifier);
    final cakeFilingManager = ref.read(cakeFilingProvider.notifier);
    final cakeFlavorManager = ref.read(cakeFlavorProvider.notifier);
    final cakeSizeManager = ref.read(cakeSizeProvider.notifier);
    final cakeIndentManager = ref.read(cakeIndentProvider.notifier);
    final cakeImagePathManager = ref.read(cakeImagePath.notifier);
    final cakeOrderManager = ref.read(requestOrderProvider.notifier);
    final isLoading = useState(false);
    final allowScroll = ref.watch(scrollProvider);
    final tabList = ["시트모양", "시트맛", "필링잼", "사이즈"];

    final tabController = useTabController(initialLength: tabList.length);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        noticeManager.requestNotices();
        cakeFilingManager.init();
        cakeFlavorManager.init();
        cakeSizeManager.init();
        canvasWidgetsManager.clearAll();
        cakeImagePathManager.state = null;
        cakeIndentManager.init();
        cakeOrderManager.init();
      });
      return () {
        Future(() {
          noticeManager.init();
        });
      };
    }, []);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        noticeState.when(
          success: (event) async {
            CommonPopup.showPopup(context, child: PopupNotice(items: event.value));
          },
          failure: (event) {
            Toast.showError(context, event.errorMessage);
          },
        );
      });
      return null;
    }, [noticeState]);

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
      bottomNavigationBar: _NextButton(isLoading: isLoading),
    );
  }
}

class _NextButton extends HookConsumerWidget {
  final ValueNotifier<bool> isLoading;

  const _NextButton({
    super.key,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusedWidgetManager = ref.read(focusedWidgetProvider.notifier);
    final cakeImagePathManager = ref.read(cakeImagePath.notifier);
    final cakeWidgets = ref.watch(canvasWidgetsProvider);

    Future<void> deleteCachedImages() async {
      Directory tempDir = await getTemporaryDirectory();
      List<FileSystemEntity> files = tempDir.listSync();

      for (FileSystemEntity file in files) {
        if (file.path.contains('cake_image')) {
          file.deleteSync();
        }
      }
    }

    Future<void> captureImage() async {
      isLoading.value = true;
      focusedWidgetManager.state = null;
      await deleteCachedImages();
      await Future.delayed(const Duration(milliseconds: 600));
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
      cakeImagePathManager.state = file.path;
    }

    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: PrimaryFilledButton.largeRect(
          onPressed: () async {
            await captureImage();

            Navigator.push(
              context,
              nextSlideScreen(
                RoutingScreen.MakeCakeInfo.route,
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
          isActivated: cakeWidgets.isNotEmpty,
        ),
      ),
    );
  }
}
