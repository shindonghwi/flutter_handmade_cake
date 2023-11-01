package make.moment.handmade_cake

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.net.URISyntaxException

class MainActivity : FlutterActivity() {

    private var CHANNEL = "webview_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getAppUrl" -> handleGetAppUrl(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun handleGetAppUrl(call: MethodCall, result: MethodChannel.Result) {
        try {
            val url: String = call.argument("url")!!
            val shouldOverride = shouldOverrideUrlLoading(url)
            result.success(shouldOverride)
        } catch (e: Exception) {
            handleError(e, result)
        }
    }

    private fun shouldOverrideUrlLoading(url: String): Boolean {
        if (url.startsWith("http://") || url.startsWith("https://")) {
            return false
        } else {
            try {
                val intent = Intent.parseUri(url, Intent.URI_INTENT_SCHEME)
                val uri = Uri.parse(intent.dataString)
                startActivity(Intent(Intent.ACTION_VIEW, uri))
                return true
            } catch (e: URISyntaxException) {
                e.printStackTrace()
                return false
            } catch (e: ActivityNotFoundException) {
                if (url.startsWith("ispmobile://")) {
                    startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=kvp.jjy.MispAndroid320")))
                    return true
                } else if (url.startsWith("kftc-bankpay://")) {
                    startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=com.kftc.bankpay.android")))
                    return true
                } else {
                    try {
                        val packagename = intent.getPackage()
                        if (packagename != null) {
                            startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("market://details?id=$packagename")))
                            return true
                        }
                    } catch (e: URISyntaxException) {
                        e.printStackTrace()
                        return false
                    }
                }
            }
        }
        return false
    }

    private fun handleError(e: Exception, result: MethodChannel.Result) {
        when (e) {
            is URISyntaxException -> {
                e.printStackTrace()
                result.error("Error", "URI Syntax Exception", null)
            }
            is ActivityNotFoundException -> {
                e.printStackTrace()
                result.error("Error", "Activity Not Found", null)
            }
            else -> {
                e.printStackTrace()
                result.error("UnknownError", "Unknown error occurred", null)
            }
        }
    }
}
