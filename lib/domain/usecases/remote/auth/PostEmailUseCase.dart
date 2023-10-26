import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/auth/RequestEmailLoginModel.dart';
import '../../../../data/models/auth/ResponseLoginModel.dart';
import '../../../../data/models/base/ApiResponse.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostEmailLoginUseCase {
  PostEmailLoginUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<ResponseLoginModel>> call({
    required String email,
    required String password,
  }) async {
    return await _remoteAuthRepository.postEmailLogin(
      requestEmailLoginModel: RequestEmailLoginModel(
        email: email,
        password: password,
      ),
    );
  }
}
