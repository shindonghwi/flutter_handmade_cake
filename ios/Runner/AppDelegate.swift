import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

    private var channel: FlutterMethodChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        HTTPCookieStorage.shared.cookieAcceptPolicy = .always
        GeneratedPluginRegistrant.register(with: self)

        if let controller = window?.rootViewController as? FlutterViewController {
            channel = FlutterMethodChannel(name: "webview_channel", binaryMessenger: controller.binaryMessenger)
            channel?.setMethodCallHandler { [weak self] (call, result) in
                self?.handle(call: call, result: result)
            }
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func handle(call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "getAppUrl" {
            guard let args = call.arguments as? [String: Any],
                  let url = args["url"] as? String else {
                result(FlutterError(code: "BAD_ARGS", message: "Missing URL argument", details: nil))
                return
            }
          let shouldOverride = shouldOverrideUrlLoading(url: url)
          result(shouldOverride)
        }
    }

    private func shouldOverrideUrlLoading(url: String) -> Bool {
        if url.starts(with: "http://") || url.starts(with: "https://") {
            return false
        } else {
            if let urlToOpen = URL(string: url) {
                if UIApplication.shared.canOpenURL(urlToOpen) {
                    UIApplication.shared.open(urlToOpen)
                    return true
                } else {
                    if url.starts(with: "ispmobile://") {
                        if let marketUrl = URL(string: "https://apps.apple.com/app/idyour_app_id_for_ispmobile") {
                            UIApplication.shared.open(marketUrl)
                            return true
                        }
                    } else if url.starts(with: "kftc-bankpay://") {
                        if let marketUrl = URL(string: "https://apps.apple.com/app/idyour_app_id_for_kftc_bankpay") {
                            UIApplication.shared.open(marketUrl)
                            return true
                        }
                    }
                }
            }
            return false
        }
    }
}
