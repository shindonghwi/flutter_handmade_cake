import 'package:get_it/get_it.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/me/RequestMeJoinModel.dart';
import '../../../repositories/remote/me/RemoteMeRepository.dart';

class PostMeJoinUseCase {
  PostMeJoinUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call(RequestMeJoinModel model) async {
    return await _remoteMeRepository.postJoin(model);
  }
}
