package make.moment.handmade_cake

import android.content.ActivityNotFoundException
import android.content.Intent
import android.content.Intent.URI_INTENT_SCHEME
import android.os.Bundle
import android.widget.Toast
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.net.URISyntaxException

class MainActivity : FlutterActivity() {

    private var CHANNEL = "fcm_default_channel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        GeneratedPluginRegistrant.registerWith(flutterEngine!!)
        val channel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
        channel.setMethodCallHandler { call, result ->
            when (call.method) {
                "getAppUrl" -> handleGetAppUrl(call, result)
                "startAct" -> handleStartActivity(call, result)
                else -> result.notImplemented()
            }
        }
    }

    private fun handleGetAppUrl(call: MethodCall, result: MethodChannel.Result) {
        Toast.makeText(this, "getAppUrl : ${call}", Toast.LENGTH_SHORT).show()
        try {
            val url: String = call.argument("url")!!
            val intent = Intent.parseUri(url, URI_INTENT_SCHEME)
            result.success(intent.dataString)
        } catch (e: Exception) {
            handleError(e, result)
        }
    }

    private fun handleStartActivity(call: MethodCall, result: MethodChannel.Result) {
        Toast.makeText(this, "startAct : ${call}", Toast.LENGTH_SHORT).show()
        try {
            val url: String = call.argument("url")!!
            val intent = Intent.parseUri(url, URI_INTENT_SCHEME)
            startActivity(intent)
            result.success("Success")
        } catch (e: Exception) {
            handleError(e, result)
        }
    }

    private fun handleError(e: Exception, result: MethodChannel.Result) {
        when (e) {
            is URISyntaxException -> {
                e.printStackTrace()
                result.error("Error", "URI Syntax Exception", null)
            }
            is ActivityNotFoundException -> {
                // 여기서 해당 앱 마켓 URL로 리다이렉션하는 로직을 추가해야 합니다.
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
