import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/base/ApiListResponse.dart';
import 'package:handmade_cake/data/models/notice/ResponseNoticeModel.dart';

import '../../../../domain/repositories/remote/notice/RemoteNoticeRepository.dart';
import '../../../data_source/remote/notice/RemoteNoticeApi.dart';

class RemoteNoticeRepositoryImpl implements RemoteNoticeRepository {
  RemoteNoticeRepositoryImpl();

  final RemoteNoticeApi _remoteNoticeApi = GetIt.instance<RemoteNoticeApi>();

  @override
  Future<ApiListResponse<List<ResponseNoticeModel>>> getNotices() {
    return _remoteNoticeApi.getNotices();
  }
}
