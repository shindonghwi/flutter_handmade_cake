import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentModel.dart';
import 'package:handmade_cake/domain/usecases/remote/order/PostOrderIndentUseCase.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/usecases/remote/order/PostImageUseCase.dart';

final requestOrderProvider = StateNotifierProvider<RequestOrderNotifier, UIState<String?>>(
  (_) => RequestOrderNotifier(),
);

class RequestOrderNotifier extends StateNotifier<UIState<String?>> {
  RequestOrderNotifier() : super(Idle<String?>());

  PostImageUseCase get _postImage => GetIt.instance<PostImageUseCase>();

  PostOrderIndentUseCase get _postOrderIndent => GetIt.instance<PostOrderIndentUseCase>();

  void requestOrder(String filePath, RequestOrderIndentModel model) async {
    state = Loading();

    await _postImage.call(filePath).then((result) async {
      if (result.status == 200) {
        final imagePath = result.data?.imagePath;
        final orderData = model.copyWith(cake: model.cake.copyWith(imagePath: imagePath));
        await _postOrderIndent.call(orderData).then((value) {
          if (result.status == 200) {
            if (!CollectionUtil.isNullEmptyFromString(value.data?.orderId.toString())){
              state = Success(value.data?.orderId.toString());
            }else{
              state = Failure(value.message);
            }
          } else {
            state = Failure(result.message);
          }
        });
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}