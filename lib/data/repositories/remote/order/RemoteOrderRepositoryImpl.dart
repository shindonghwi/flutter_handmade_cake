import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/data_source/remote/order/RemoteOrderApi.dart';
import 'package:handmade_cake/data/models/me/RequestMeJoinModel.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentModel.dart';
import 'package:handmade_cake/data/models/order/ResponseOrderImageModel.dart';
import 'package:handmade_cake/data/models/order/ResponseOrderIndentModel.dart';
import 'package:handmade_cake/domain/repositories/remote/order/RemoteOrderRepository.dart';

import '../../../../domain/repositories/remote/me/RemoteMeRepository.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteOrderRepositoryImpl implements RemoteOrderRepository {
  RemoteOrderRepositoryImpl();

  RemoteOrderApi remoteOrderApi = GetIt.instance<RemoteOrderApi>();

  @override
  Future<ApiResponse<ResponseOrderImageModel>> postImage(String filePath) {
    return remoteOrderApi.postImage(filePath);
  }

  @override
  Future<ApiResponse<ResponseOrderIndentModel>> postIndent(RequestOrderIndentModel model) {
    return remoteOrderApi.postIndent(model);
  }

}
