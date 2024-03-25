import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/base/ApiResponse.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import '../../../models/me/RequestMeJoinModel.dart';
import '../../../models/me/ResponseMeInfoModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteMeApi {
  RemoteMeApi();

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 내 정보 요청
  Future<ApiResponse<ResponseMeInfoModel>> getMe() async {
    final response = await Service.getApi(
      type: ServiceType.Me,
      endPoint: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => ResponseMeInfoModel.fromJson(json),
      );
    }
  }

  /// 비밀번호 변경
  Future<ApiResponse<void>> patchPw(String password) async {
    final response = await Service.patchApi(
      type: ServiceType.Me,
      endPoint: "password",
      jsonBody: {"password": password},
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) {},
      );
    }
  }

  /// 회원가입
  Future<ApiResponse<void>> postJoin(RequestMeJoinModel model) async {
    final response = await Service.postApi(
      type: ServiceType.Me,
      endPoint: "join",
      jsonBody: model.toJson(),
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) => {},
      );
    }
  }

  /// 회원 탈퇴
  Future<ApiResponse<void>> postMeLeave() async {
    final response = await Service.postApi(
      type: ServiceType.Me,
      endPoint: "leave",
      jsonBody: null,
    );

    final errorResponse = BaseApiUtil.isErrorStatusCode(response);
    if (errorResponse != null) {
      return ApiResponse(
        status: errorResponse.status,
        message: errorResponse.message,
        data: null,
      );
    } else {
      return ApiResponse.fromJson(
        jsonDecode(response.body),
        (json) {},
      );
    }
  }

}
