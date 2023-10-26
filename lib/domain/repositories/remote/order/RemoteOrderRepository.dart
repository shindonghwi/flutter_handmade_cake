import 'dart:async';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/order/RequestOrderIndentModel.dart';
import '../../../../data/models/order/ResponseOrderImageModel.dart';
import '../../../../data/models/order/ResponseOrderIndentModel.dart';

abstract class RemoteOrderRepository {
  /// 주문 접수 등록
  Future<ApiResponse<ResponseOrderIndentModel>> postIndent(RequestOrderIndentModel model);

  /// 주문 이미지 등록
  Future<ApiResponse<ResponseOrderImageModel>> postImage(String filePath);
}
