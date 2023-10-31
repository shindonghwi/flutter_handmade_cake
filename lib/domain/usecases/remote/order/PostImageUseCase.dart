import 'package:get_it/get_it.dart';
import 'package:handmade_cake/domain/repositories/remote/order/RemoteOrderRepository.dart';

import '../../../../data/models/base/ApiResponse.dart';
import '../../../../data/models/order/ResponseOrderImageModel.dart';
import '../../../repositories/remote/me/RemoteMeRepository.dart';

class PostImageUseCase {
  PostImageUseCase();

  final RemoteOrderRepository _remoteOrderRepository = GetIt.instance<RemoteOrderRepository>();

  Future<ApiResponse<ResponseOrderImageModel>> call(String filePath) async {
    return await _remoteOrderRepository.postImage(filePath);
  }
}
