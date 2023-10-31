import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends HookWidget {
  final String webViewUrl;

  const PaymentWebViewScreen({
    Key? key,
    this.webViewUrl = "",
  }) : super(key: key);

  void onMessageReceived(WebViewController controller, JavascriptMessage message) {
    debugPrint("웹에서 플러터앱으로 메시지 전송: ${message.message}");
  }

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      StreamSubscription subscription;
      subscription = uriLinkStream.listen((Uri? link) {
        debugPrint("uriLinkStream: ${link.toString()}");
      }, onError: (err) {});
      return () => subscription.cancel();
    }, []);

    MethodChannel channel = const MethodChannel("fcm_default_channel");

    String? extractPackageNameFromUrl(String url) {
      final match = RegExp(r';package=([^;]+)').firstMatch(url);
      return match?.group(1);
    }

    String? extractSchemeFromUrl(String url) {
      final match = RegExp(r'scheme=([^;]+)').firstMatch(url);
      return match?.group(1);
    }

    Future<void> redirectToStore(String? packageName) async {
      String marketUrl = '';
      if (Platform.isAndroid) {
        marketUrl = 'https://play.google.com/store/apps/details?id=$packageName';
      } else if (Platform.isIOS) {
        marketUrl = 'https://apps.apple.com/us/app/id$packageName'; // 주의: iOS의 경우 id 뒤에 해당 앱의 App Store ID가 필요합니다.
      }

      if (await canLaunch(marketUrl)) {
        await launch(marketUrl);
      } else {
        Toast.showError(context, "마켓으로 이동할 수 없습니다");
      }
    }

    Future getAppUrl(String url) async {
      await channel.invokeMethod('getAppUrl', <String, Object>{'url': url}).then((value) async {
        debugPrint('paring url : $value');

        if (value.toString().startsWith('ispmobile://')) {
          await channel.invokeMethod('startAct', <String, Object>{'url': url}).then((value) {
            debugPrint('parsing url : $value');
            return;
          });
        }

        if (await canLaunchUrl(Uri.parse(value))) {
          await launchUrl(
            Uri.parse(value),
          );
          return;
        } else {
          String? packageName = extractPackageNameFromUrl(url);
          debugPrint('packageName : $packageName');
          if (!CollectionUtil.isNullEmptyFromString(packageName)) {
            await redirectToStore(packageName);
            Toast.showError(context, "해당 앱 설치 후 이용바랍니다");
          } else {
            String? scheme = extractSchemeFromUrl(url);
            if (!CollectionUtil.isNullEmptyFromString(scheme)) {
              Toast.showError(context, "$scheme 앱 설치 후 이용바랍니다");
            } else {
              Toast.showError(context, "링크를 열 수 없습니다");
            }
          }
          return;
        }
      });
    }

    final isLoading = useState(true);
    final controller = useState<WebViewController?>(null);

    return BaseScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          WebView(
            initialUrl: webViewUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              controller.value = webViewController;
            },
            onPageStarted: (String url) {
              debugPrint("onPageStarted: $url");
              isLoading.value = true;
            },
            onPageFinished: (String url) {
              debugPrint("onPageFinished: $url");
              isLoading.value = false;
            },
            navigationDelegate: (NavigationRequest request) async {
              debugPrint("navigationDelegate: ${request.url}");
              if (!request.url.startsWith('http') && !request.url.startsWith('https')) {
                if (Platform.isAndroid) {
                  getAppUrl(request.url.toString());
                  return NavigationDecision.prevent;
                } else if (Platform.isIOS) {
                  if (await canLaunchUrl(Uri.parse(request.url))) {
                    debugPrint('navigate url : ${request.url}');
                    await launchUrl(
                      Uri.parse(request.url),
                    );
                    return NavigationDecision.prevent;
                  }
                }
              }

              return NavigationDecision.navigate;
            },
            javascriptChannels: <JavascriptChannel>{
              JavascriptChannel(
                name: 'toApp',
                onMessageReceived: (message) {
                  var jsonData = jsonDecode(message.message);
                  debugPrint("웹에서 플러터앱으로 메시지 전송: ${jsonData}");

                  final status = jsonData['status'];
                  final msg = jsonData['message'];

                  print("@#@@#@#@#@# status: $status");
                  print("@#@@#@#@#@# msg: $msg");

                  if (status == "200") {
                    Toast.showSuccess(context, "결제가 완료되었습니다");
                    Navigator.pushAndRemoveUntil(
                      context,
                      nextSlideScreen(RoutingScreen.Main.route),
                      (route) => false,
                    );
                  } else {
                    Toast.showSuccess(context, "결제에 실패하였습니다");
                    Navigator.of(context).pop();
                  }
                },
              ),
            },
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
    );
  }
}
