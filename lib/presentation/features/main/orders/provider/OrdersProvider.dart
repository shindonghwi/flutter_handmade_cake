import 'package:get_it/get_it.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';
import 'package:handmade_cake/domain/usecases/remote/order/GetOrdersUseCase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../data/data_source/remote/HeaderKey.dart';
import '../../../../../data/data_source/remote/Service.dart';
import '../../../../../domain/usecases/local/app/PostLoginAccessTokenUseCase.dart';
import '../../../../../domain/usecases/remote/auth/PostLogoutUseCase.dart';
import '../../../../model/UiState.dart';

final ordersProvider = StateNotifierProvider<OrdersNotifier, UIState<List<ResponseOrdersModel>>>(
  (_) => OrdersNotifier(),
);

class OrdersNotifier extends StateNotifier<UIState<List<ResponseOrdersModel>>> {
  OrdersNotifier() : super(Idle());

  GetOrdersUseCase get _getOrders => GetIt.instance<GetOrdersUseCase>();

  void requestOrders({int delay = 0}) async {
    state = Loading();

    await Future.delayed(Duration(milliseconds: delay));

    await _getOrders.call().then((result) {
      if (result.status == 200) {
        state = Success(result.list ?? []);
      } else {
        state = Failure(result.message);
      }
    });
  }

  void init() => state = Idle();
}
