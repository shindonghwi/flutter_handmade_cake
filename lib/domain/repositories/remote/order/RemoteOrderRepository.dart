import 'dart:async';

import 'package:handmade_cake/data/models/base/ApiListResponse.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/order/RequestOrderIndentModel.dart';
import '../../../../data/models/order/ResponseOrderImageModel.dart';
import '../../../../data/models/order/ResponseOrderIndentModel.dart';

abstract class RemoteOrderRepository {
  /// 주문 접수 등록
  Future<ApiResponse<ResponseOrderIndentModel>> postIndent(RequestOrderIndentModel model);

  /// 주문 이미지 등록
  Future<ApiResponse<ResponseOrderImageModel>> postImage(String filePath);

  /// 주문 목록 조회
  Future<ApiListResponse<List<ResponseOrdersModel>>> getOrders();

  /// 주문 상세 조회
  Future<ApiResponse<ResponseOrderImageModel>> getOrder(int orderId);
}
