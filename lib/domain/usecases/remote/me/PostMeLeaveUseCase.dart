import 'package:get_it/get_it.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../repositories/remote/me/RemoteMeRepository.dart';

class PostMeLeaveUseCase {
  PostMeLeaveUseCase();

  final RemoteMeRepository _remoteMeRepository = GetIt.instance<RemoteMeRepository>();

  Future<ApiResponse<void>> call() async {
    return await _remoteMeRepository.postMeLeave();
  }
}
