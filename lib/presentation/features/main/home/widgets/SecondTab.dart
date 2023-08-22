import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class SecondTab extends HookWidget {
  const SecondTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> imageUrls = [
      "https://m.lgart.com/Down/Perf/202212/%EA%B0%80%EB%A1%9C%EA%B4%91%EA%B3%A01920x1080-3.jpg",
      "https://marketplace.canva.com/EAD2xI0GoM0/1/0/800w/canva-%ED%95%98%EB%8A%98-%EC%95%BC%EC%99%B8-%EC%9E%90%EC%97%B0-%EC%98%81%EA%B0%90-%EC%9D%B8%EC%9A%A9%EB%AC%B8-%EB%8D%B0%EC%8A%A4%ED%81%AC%ED%86%B1-%EB%B0%B0%EA%B2%BD%ED%99%94%EB%A9%B4-CQJp-Sw9JRs.jpg",
      "https://blog.kakaocdn.net/dn/9Yg2I/btqNJwwHIUS/WNhMAC34BopDSvpKmhy9X0/img.jpg",
      "https://mblogthumb-phinf.pstatic.net/MjAxOTA3MjlfMjAx/MDAxNTY0NDAxNjEzNDgy.jrcSPgSZ1C52bTn0Lt9fhdX7qFPUts6qI7bp17GcjVsg.CfQRIEKV2qNwFFH-29TuveeZhB5PtgjyRzZoQ0dessUg.JPEG.msme3/940581-popular-disney-wallpaper-for-computer-1920x1080-for-iphone-5.jpg?type=w800",
      "https://blog.kakaocdn.net/dn/9Yg2I/btqNJwwHIUS/WNhMAC34BopDSvpKmhy9X0/img.jpg",
      "https://www.10wallpaper.com/wallpaper/2560x1600/1702/Sea_dawn_nature_sky-High_Quality_Wallpaper_2560x1600.jpg",
      "htaatps://blog.kakaocdn.net/dn/daPJMD/btqCinzhh9J/akDK6BMiG3QKH3XWXwobx1/img.jpg",
    ];

    final scrollController = useScrollController();

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
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/imgs/image_home_appbar.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          const SizedBox(height: 20),
                          CircularProgressIndicator(
                            color: getColorScheme(context).colorPrimary900,
                            strokeWidth: 1.0,
                          ),
                        ],
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Center(
                      child: SvgPicture.asset(
                        "assets/imgs/image_home_appbar.svg",
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
