import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
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
    final isLoading = useState(true);

    debugPrint("webViewUrl: $webViewUrl");

    final controller = useState<WebViewController?>(null);

    void _launchURL(BuildContext context, String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Unable to launch $url')),
        );
      }
    }

    return BaseScaffold(
      appBar: const TopBarIconTitleText(
        content: "결제하기",
      ),
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
            navigationDelegate: (NavigationRequest request) {
              final url = request.url;
              debugPrint("navigationDelegate: $url");
              if (url.startsWith('http://') || url.startsWith('https://')) {
                return NavigationDecision.navigate;
              } else if (url.startsWith("ispmobile://")) {
                _launchURL(context, "market://details?id=kvp.jjy.MispAndroid320");
                return NavigationDecision.prevent;
              } else if (url.startsWith("kftc-bankpay://")) {
                _launchURL(context, "market://details?id=com.kftc.bankpay.android");
                return NavigationDecision.prevent;
              } // ... 여기에 다른 URL 스키마 조건을 추가
              else {
                _launchURL(context, url);  // 이 코드는 기본 앱을 열기 위해 사용됩니다.
                return NavigationDecision.prevent;
              }
            },
            javascriptChannels: <JavascriptChannel>{
              JavascriptChannel(
                name: 'toApp',
                onMessageReceived: (message) => onMessageReceived(controller.value!, message),
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
