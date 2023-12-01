import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarTitle.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/features/main/orders/provider/OrdersProvider.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends HookConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersState = ref.watch(ordersProvider);
    final ordersManager = ref.read(ordersProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ordersManager.requestOrders();
      });
      return null;
    }, []);

    debugPrint("ordersState: $ordersState");

    return BaseScaffold(
      backgroundColor: getColorScheme(context).white,
      appBar: const TopBarTitle(
        content: "주문 내역",
      ),
      body: Stack(
        children: [
          if (ordersState is Success<List<ResponseOrdersModel>>)
            if (ordersState.value.isNotEmpty)
              RefreshIndicator(
                color: getColorScheme(context).colorPrimary500,
                onRefresh: () async {
                  ordersManager.requestOrders(delay: 500);
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    color: getColorScheme(context).colorGray300,
                  ),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 40),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: ordersState.value.length,
                  itemBuilder: (context, index) {
                    return _OrderItem(item: ordersState.value[index]);
                  },
                ),
              )
            else
              Center(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "주문 내역이 없습니다.",
                    style: getTextTheme(context).medium.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).colorGray500,
                        ),
                  ),
                ),
              ),
          if (ordersState is Loading) const LoadingView()
        ],
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final ResponseOrdersModel item;

  const _OrderItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.status,
                  style: getTextTheme(context).bold.copyWith(
                        fontSize: 14,
                        color: getColorScheme(context).black,
                      ),
                ),
                Clickable(
                  onPressed: () {
                    Navigator.push(
                      context,
                      nextSlideScreen(
                        RoutingScreen.DetailOrder.route,
                        parameter: item.orderId
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            "주문상세",
                            style: getTextTheme(context).medium.copyWith(
                                  fontSize: 12,
                                  color: getColorScheme(context).black,
                                ),
                          ),
                        ),
                        Transform.rotate(
                          angle: 180 * 3.14 / 180,
                          child: SvgPicture.asset(
                            "assets/imgs/icon_back.svg",
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              getColorScheme(context).black,
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 160,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 140,
                  height: 140,
                  margin: const EdgeInsets.only(left: 24.0),
                  child: CachedNetworkImage(
                    imageUrl: item.cake.imageUrl,
                    placeholder: (context, url) => SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          getColorScheme(context).colorPrimary500,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Text(
                        "Image Load Failed!",
                        style: getTextTheme(context).medium.copyWith(
                              fontSize: 12,
                              color: getColorScheme(context).colorGray200,
                            ),
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.createdDate,
                              style: getTextTheme(context).medium.copyWith(
                                    fontSize: 12,
                                    color: getColorScheme(context).colorGray500,
                                  ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                item.message.reason,
                                style: getTextTheme(context).semiBold.copyWith(
                                      fontSize: 24,
                                      color: getColorScheme(context).black,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "사이즈: ${item.cake.size}\n맛: ${item.cake.taste} / ${item.cake.jam}\n데코레이션: ${item.cake.decorations.join(", ")}",
                              style: getTextTheme(context).medium.copyWith(
                                    fontSize: 12,
                                    color: getColorScheme(context).colorGray500,
                                    height: 1.4,
                                  ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "${NumberFormat('#,###').format(int.parse(item.price.total.toString()))}원",
                                style: getTextTheme(context).semiBold.copyWith(
                                      fontSize: 16,
                                      color: getColorScheme(context).black,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
