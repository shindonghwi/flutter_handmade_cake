import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../../models/base/ApiResponse.dart';

class BaseApiUtil {
  static AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  static ApiResponse? isErrorStatusCode(Response res) {
    if (res.statusCode >= 500) {
      return ApiResponse(
        status: res.statusCode,
        message: _getAppLocalization.get().message_server_error_5xx.toString(),
        data: null,
      );
    } else if (res.statusCode == 406) {
      return ApiResponse(
        status: res.statusCode,
        message: _getAppLocalization.get().message_network_required.toString(),
        data: null,
      );
    } else if (res.statusCode == 403) {
      return ApiResponse(
        status: res.statusCode,
        message: res.body,
        data: null,
      );
    }
    return null;
  }

  static http.Response createResponse(String body, int statusCode) {
    return http.Response(utf8.encode(body).toString(), statusCode);
  }
}
