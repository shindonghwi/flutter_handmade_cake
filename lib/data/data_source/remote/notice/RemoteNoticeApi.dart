import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

import '../../../models/base/ApiListResponse.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteNoticeApi {
  RemoteNoticeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 주문 목록 조회
  Future<ApiListResponse<List<ResponseNoticeModel>>> getNotices() async {
    final response = await Service.getApi(
      type: ServiceType.Notice,
      endPoint: null,
      query: "page=1&size=500",
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiListResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        count: 0,
        list: [],
      );
    } else {
      return ApiListResponse.fromJson(
        jsonDecode(response.body),
            (json) {
          return List<ResponseNoticeModel>.from(
            json.map((item) => ResponseNoticeModel.fromJson(item as Map<String, dynamic>)),
          );
        },
      );
    }
  }

}
