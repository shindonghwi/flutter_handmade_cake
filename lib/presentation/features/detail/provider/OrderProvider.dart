import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';
import 'package:handmade_cake/domain/usecases/remote/order/GetOrderUseCase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/UiState.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, UIState<ResponseOrdersModel>>(
  (_) => OrderNotifier(),
);

class OrderNotifier extends StateNotifier<UIState<ResponseOrdersModel>> {
  OrderNotifier() : super(Idle());

  GetOrderUseCase get _getOrder => GetIt.instance<GetOrderUseCase>();

  void requestOrderInfo(int orderId) async {
    state = Loading();

    await _getOrder.call(orderId).then((result) {
      if (result.status == 200) {
        state = Success(result.data!);
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
