import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/base/ApiResponse.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentModel.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

import '../../../models/order/ResponseOrderImageModel.dart';
import '../../../models/order/ResponseOrderIndentModel.dart';
import '../BaseApiUtil.dart';
import '../Service.dart';

class RemoteOrderApi {
  RemoteOrderApi();

  static final allowedExtensionsImage = ['jpg', 'jpeg', 'png'];
  static final allowedExtensionsVideo = ['mp4', 'avi', 'mov', 'flv'];

  AppLocalization get _getAppLocalization => GetIt.instance<AppLocalization>();

  /// 주문 접수 등록
  Future<ApiResponse<ResponseOrderIndentModel>> postIndent(RequestOrderIndentModel model) async {
    final response = await Service.postApi(
      type: ServiceType.Order,
      endPoint: "indent",
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
        (json) => ResponseOrderIndentModel.fromJson(json),
      );
    }
  }

  /// 주문 이미지 등록
  Future<ApiResponse<ResponseOrderImageModel>> postImage(String filePath) async {
    final file = File(filePath);

    if (!file.existsSync()) {
      return ApiResponse(
        status: 404,
        message: _getAppLocalization.get().message_file_not_found_404,
        data: null,
      );
    } else if (!allowedExtensionsImage.contains(file.path.split('.').last)) {
      return ApiResponse(
        status: 400,
        message: _getAppLocalization.get().message_file_not_allow_404,
        data: null,
      );
    }

    final response = await Service.postUploadApi(
      type: ServiceType.Order,
      endPoint: "image",
      file: file,
      jsonBody: {},
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
        (json) => ResponseOrderImageModel.fromJson(json),
      );
    }
  }
}
