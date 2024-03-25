import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/me/RequestMeJoinModel.dart';

import '../../../../domain/repositories/remote/me/RemoteMeRepository.dart';
import '../../../data_source/remote/me/RemoteMeApi.dart';
import '../../../models/base/ApiResponse.dart';
import '../../../models/me/ResponseMeInfoModel.dart';

class RemoteMeRepositoryImpl implements RemoteMeRepository {
  RemoteMeRepositoryImpl();

  RemoteMeApi remoteMeApi = GetIt.instance<RemoteMeApi>();

  @override
  Future<ApiResponse<ResponseMeInfoModel>> getMe() {
    return remoteMeApi.getMe();
  }

  @override
  Future<ApiResponse<void>> patchPw(String password) {
    return remoteMeApi.patchPw(password);
  }

  @override
  Future<ApiResponse<void>> postJoin(RequestMeJoinModel model) {
    return remoteMeApi.postJoin(model);
  }

  @override
  Future<ApiResponse<void>> postMeLeave() {
    return remoteMeApi.postMeLeave();
  }
}
