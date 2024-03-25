import 'package:get_it/get_it.dart';
import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/ResponseMeInfoModel.dart';
import '../../../repositories/remote/me/RemoteMeRepository.dart';

class GetMeInfoUseCase {
  GetMeInfoUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<ResponseMeInfoModel>> call() async {
    return await _remoteMeRepository.getMe();
  }
}
