import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/base/ApiListResponse.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';
import 'package:handmade_cake/domain/repositories/remote/notice/RemoteNoticeRepository.dart';
import 'package:handmade_cake/domain/repositories/remote/order/RemoteOrderRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/order/RequestOrderIndentModel.dart';
import '../../../../data/models/order/ResponseOrderImageModel.dart';
import '../../../../data/models/order/ResponseOrderIndentModel.dart';
import '../../../repositories/remote/me/RemoteMeRepository.dart';

class GetNoticesUseCase {
  GetNoticesUseCase();

  final RemoteNoticeRepository _remoteNoticeRepository = GetIt.instance<RemoteNoticeRepository>();

  Future<ApiListResponse<List<ResponseNoticeModel>>> call() async {
    return await _remoteNoticeRepository.getNotices();
  }
}
