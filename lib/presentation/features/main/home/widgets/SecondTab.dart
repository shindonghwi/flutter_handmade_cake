import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/button/PrimaryFilledButton.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:photo_view/photo_view.dart';

class SecondTab extends HookWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    useAutomaticKeepAlive();

    final List<String> imageUrls = [
      "assets/imgs/cake1.png",
      "assets/imgs/cake2.png",
      "assets/imgs/cake3.png",
      "assets/imgs/cake4.png",
      "assets/imgs/cake5.png",
      "assets/imgs/cake6.png",
      "assets/imgs/cake7.png",
      "assets/imgs/cake8.png",
      "assets/imgs/cake9.png",
    ];

    final scrollController = useScrollController();

    void showImage(BuildContext context, String imagePath) {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black.withOpacity(0.8),
        // dim 처리 부분의 색상
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: PhotoView(
                        imageProvider: AssetImage(imagePath),
                        minScale: PhotoViewComputedScale.covered,
                        maxScale: PhotoViewComputedScale.covered,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 60.0),
                    child: PrimaryFilledButton.normalRect(
                      content: Text(
                        "닫기",
                        style: getTextTheme(context).bold.copyWith(
                              fontSize: 16,
                              color: getColorScheme(context).white,
                            ),
                      ),
                      isActivated: true,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 20,
          ),
          controller: scrollController,
          itemCount: imageUrls.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColorScheme(context).colorGray300,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Clickable(
                  onPressed: () {
                    showImage(context, imageUrls[index]);
                  },
                  child: Image.asset(
                    imageUrls[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
