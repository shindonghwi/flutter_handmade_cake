import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/data/models/order/ResponseOrdersModel.dart';
import 'package:handmade_cake/presentation/components/appbar/TopBarIconTitleText.dart';
import 'package:handmade_cake/presentation/components/toast/Toast.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/view_state/FailView.dart';
import 'package:handmade_cake/presentation/components/view_state/LoadingView.dart';
import 'package:handmade_cake/presentation/model/UiState.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/ui/typography.dart';
import 'package:handmade_cake/presentation/utils/CollectionUtil.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'provider/OrderProvider.dart';

class DetailOrderScreen extends HookConsumerWidget {
  final int orderId;

  const DetailOrderScreen({
    super.key,
    this.orderId = -1,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderState = ref.watch(orderProvider);
    final orderManager = ref.read(orderProvider.notifier);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (orderId == -1) {
          Toast.showError(context, "주문 상세정보를 조회 할 수 없습니다");
          await Future.delayed(const Duration(milliseconds: 500));
          Navigator.of(context).pop();
        } else {
          orderManager.requestOrderInfo(orderId);
        }
      });
      return () {
        Future(() {
          orderManager.init();
        });
      };
    }, []);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          orderState.when(
            failure: (event) => Toast.showError(context, event.errorMessage),
          );
        });
      }

      handleUiStateChange();
      return null;
    }, [orderState]);

    return BaseScaffold(
      appBar: const TopBarIconTitleText(content: '주문상세'),
      backgroundColor: getColorScheme(context).white,
      body: SafeArea(
        child: Stack(
          children: [
            if (orderState is Success<ResponseOrdersModel>)
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CakeInfo(item: orderState.value),
                      Container(
                        width: double.infinity,
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        color: getColorScheme(context).colorGray300,
                      ),
                      _ReceiverInfo(item: orderState.value),
                      Container(
                        width: double.infinity,
                        height: 1,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        color: getColorScheme(context).colorGray300,
                      ),
                      _PriceInfo(item: orderState.value),
                    ],
                  ),
                ),
              ),
            if (orderState is Loading) const LoadingView(),
            if (orderState is Failure) FailView(onPressed: () => orderManager.requestOrderInfo(orderId)),
          ],
        ),
      ),
    );
  }
}

class _CakeInfo extends StatelessWidget {
  const _CakeInfo({
    super.key,
    required this.item,
  });

  final ResponseOrdersModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.message.reason,
          style: getTextTheme(context).semiBold.copyWith(
                fontSize: 24,
                color: getColorScheme(context).black,
              ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: AspectRatio(
            aspectRatio: 342 / 260,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: getColorScheme(context).colorGray300,
                  width: 1,
                ),
              ),
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "케이크 정보",
                style: getTextTheme(context).semiBold.copyWith(
                      fontSize: 20,
                      color: getColorScheme(context).black,
                    ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "사이즈",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                  Text(
                    item.cake.size,
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 12,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "맛",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                  Text(
                    "${item.cake.taste} / ${item.cake.jam}",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 12,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "데코레이션",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 14,
                          color: getColorScheme(context).black,
                        ),
                  ),
                  Text(
                    item.cake.decorations.isNotEmpty ? item.cake.decorations.join(", ") : "없음",
                    style: getTextTheme(context).regular.copyWith(
                          fontSize: 12,
                          color: getColorScheme(context).black,
                        ),
                  ),
                ],
              ),
              if (!CollectionUtil.isNullEmptyFromString(item.message.request))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      "요청사항",
                      style: getTextTheme(context).regular.copyWith(
                            fontSize: 14,
                            color: getColorScheme(context).black,
                          ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        item.message.request!,
                        style: getTextTheme(context).regular.copyWith(
                              fontSize: 12,
                              color: getColorScheme(context).colorGray500,
                            ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        )
      ],
    );
  }
}

class _ReceiverInfo extends StatelessWidget {
  const _ReceiverInfo({
    super.key,
    required this.item,
  });

  final ResponseOrdersModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "수령인 정보",
          style: getTextTheme(context).semiBold.copyWith(
                fontSize: 20,
                color: getColorScheme(context).black,
              ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "이름",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              item.receiver?.name ?? "",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 12,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "연락처",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              item.receiver?.phone ?? "",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 12,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "주소",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              item.receiver?.address ?? "",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 12,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceInfo extends StatelessWidget {
  const _PriceInfo({
    super.key,
    required this.item,
  });

  final ResponseOrdersModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "총 가격",
          style: getTextTheme(context).semiBold.copyWith(
                fontSize: 20,
                color: getColorScheme(context).black,
              ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "케이크 가격",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              "${NumberFormat('#,###').format(int.parse(item.price.total.toString()) - 4900)}원",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 12,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "배송비",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              "4,900원",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 12,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "합계",
              style: getTextTheme(context).regular.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
            Text(
              "${NumberFormat('#,###').format(int.parse(item.price.total.toString()))}원",
              style: getTextTheme(context).bold.copyWith(
                    fontSize: 14,
                    color: getColorScheme(context).black,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
