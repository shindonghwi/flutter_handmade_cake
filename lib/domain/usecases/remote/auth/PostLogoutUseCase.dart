import 'package:get_it/get_it.dart';
import '../../../../data/models/base/ApiResponse.dart';
import '../../../repositories/remote/auth/RemoteAuthRepository.dart';

class PostLogoutUseCase {
  PostLogoutUseCase();

  final RemoteAuthRepository _remoteAuthRepository = GetIt.instance<RemoteAuthRepository>();

  Future<ApiResponse<void>> call() async {
    return await _remoteAuthRepository.postLogout();
  }
}
