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
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
    MethodChannel channel = const MethodChannel("webview_channel");

    final isLoading = useState(true);
    final controller = useState<WebViewController?>(null);
    final lastUrl = useState<String?>(null);

    return BaseScaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            WebView(
              initialUrl: webViewUrl,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                controller.value = webViewController;

                if (Platform.isIOS) {
                  webViewController.clearCache();
                }
              },
              onPageStarted: (String url) {
                debugPrint("onPageStarted: $url");
                isLoading.value = true;
              },
              onPageFinished: (String url) {
                debugPrint("onPageFinished: $url");
                isLoading.value = false;
                lastUrl.value = url;
              },
              onWebResourceError: (error) {
                debugPrint("WebView error: ${error.description}");
                debugPrint("WebView error: ${error.domain}");
                debugPrint("WebView error: ${error.errorCode}");
                debugPrint("WebView error: ${error.errorType}");
                debugPrint("WebView error: ${error.failingUrl}");
                controller.value?.reload();
              },
              navigationDelegate: (NavigationRequest request) async {
                debugPrint("navigationDelegate: ${request.url}");
                var url = request.url;
                final uri = Uri.parse(request.url);

                if (url.startsWith('http://') || url.startsWith('https://')) {
                  return NavigationDecision.navigate; // WebView에서 URL 로딩
                }

                bool? shouldOverride;

                if (Platform.isAndroid || Platform.isIOS) {
                  shouldOverride = await channel.invokeMethod('getAppUrl', <String, Object>{'url': request.url});
                }

                if (shouldOverride == true) {
                  return NavigationDecision.prevent;
                } else if (Platform.isIOS) {
                  if (uri.scheme == 'about' && uri.path == 'blank') {
                    debugPrint("Skipping special URL: $uri"); // Log
                    return NavigationDecision.navigate;
                  }

                  debugPrint("Attempting to launch URL: $uri"); // 로그 추가

                  if (await canLaunchUrlString(url)) {
                    try {
                      await launchUrlString(url);
                    } catch (e) {
                      print("Error launching URL: $e");
                    }

                    Future.delayed(const Duration(seconds: 1), () {
                      if (lastUrl.value != null) {
                        controller.value?.loadUrl(lastUrl.value!);
                      }
                    });
                    return NavigationDecision.prevent;
                  } else {
                    Toast.showError(context, "앱 설치 후 이용해주세요");
                    debugPrint("Couldn't launch URL: $uri"); // 로그 추가
                  }
                  return NavigationDecision.prevent;
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

                    debugPrint("@#@@#@#@#@# status: $status");
                    debugPrint("@#@@#@#@#@# msg: $msg");

                    if (status == "200") {
                      Toast.showSuccess(context, "결제가 완료되었습니다");
                      Navigator.pushAndRemoveUntil(
                        context,
                        nextSlideScreen(RoutingScreen.MakeCakeComplete.route),
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
      ),
    );
  }
}
