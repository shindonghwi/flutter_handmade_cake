import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/auth/RequestEmailLoginModel.dart';
import 'package:handmade_cake/data/models/auth/ResponseLoginModel.dart';
import 'package:handmade_cake/data/models/base/ApiResponse.dart';
import '../../../../domain/repositories/remote/auth/RemoteAuthRepository.dart';
import '../../../data_source/remote/auth/RemoteAuthApi.dart';

class RemoteAuthRepositoryImpl implements RemoteAuthRepository {
  RemoteAuthRepositoryImpl();

  RemoteAuthApi remoteAuthApi = GetIt.instance<RemoteAuthApi>();

  @override
  Future<ApiResponse<ResponseLoginModel>> postEmailLogin({required RequestEmailLoginModel requestEmailLoginModel}) {
    return remoteAuthApi.postEmailLogin(requestEmailLoginModel: requestEmailLoginModel);
  }

  @override
  Future<ApiResponse<void>> postLogout() {
    return remoteAuthApi.postLogout();
  }

}
