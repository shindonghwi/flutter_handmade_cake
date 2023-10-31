import 'package:flutter/cupertino.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentCake.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentDecoration.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentMessage.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentModel.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentPrice.dart';
import 'package:handmade_cake/data/models/order/RequestOrderIndentReceiver.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeFilingProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeFlavorProvider.dart';
import 'package:handmade_cake/presentation/features/cake_make_step/provider/CakeSizeProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

final cakeIndentProvider = StateNotifierProvider<CakeIndentNotifier, RequestOrderIndentModel>((_) {
  return CakeIndentNotifier();
});

class CakeIndentNotifier extends StateNotifier<RequestOrderIndentModel> {
  CakeIndentNotifier()
      : super(
          RequestOrderIndentModel(
            message: RequestOrderIndentMessage(reason: "", request: "", memo: ""),
            receiver: RequestOrderIndentReceiver(name: "", phone: "", address: ""),
            price: RequestOrderIndentPrice(total: 0),
            cake: RequestOrderIndentCake(
              size: CakeSizeType.One.transText,
              sheet: "",
              taste: FlavorType.Vanilla.transText,
              jam: FilingType.Blueberry.transText,
              imagePath: "",
              decorations: [],
            ),
            payment: "CARD",
          ),
        );

  void updateMessage(String reason, String request) {
    state = state.copyWith(message: state.message.copyWith(reason: reason, request: request));
    debugPrint("Cake sheet : $state");
  }

  void updateMemo(String memo) {
    state = state.copyWith(message: state.message.copyWith(memo: memo));
    debugPrint("Cake sheet : $state");
  }

  void updateReceiverName(String name) {
    state = state.copyWith(receiver: state.receiver.copyWith(name: name));
    debugPrint("Cake sheet : $state");
  }

  void updateReceiverPhone(String phone) {
    state = state.copyWith(receiver: state.receiver.copyWith(phone: phone));
    debugPrint("Cake sheet : $state");
  }

  void updateReceiverAddress(String address) {
    state = state.copyWith(receiver: state.receiver.copyWith(address: address));
    debugPrint("Cake sheet : $state");
  }

  void updatePrice(int price) {
    state = state.copyWith(price: state.price.copyWith(total: price));
    debugPrint("Cake sheet : $state");
  }

  void updateCakeSize(CakeSizeType size) {
    state = state.copyWith(cake: state.cake.copyWith(size: size.transText));
    debugPrint("Cake sheet : $state");
  }

  void updateTaste(FlavorType type) {
    state = state.copyWith(cake: state.cake.copyWith(taste: type.transText));
    debugPrint("Cake sheet : $state");
  }

  void updateJam(FilingType type) {
    state = state.copyWith(cake: state.cake.copyWith(jam: type.transText));
    debugPrint("Cake sheet : $state");
  }

  void updateCakeImagePath(String path) {
    state = state.copyWith(cake: state.cake.copyWith(imagePath: path));
    debugPrint("Cake sheet : $state");
  }

  void addDecoration(String type) {
    List<RequestOrderIndentDecoration> decorations = List.from(state.cake.decorations);

    bool found = false;
    List<RequestOrderIndentDecoration> updatedDecorations = [];

    for (RequestOrderIndentDecoration decoration in decorations) {
      if (decoration.type == type) {
        // Create a new decoration with incremented count
        updatedDecorations.add(decoration.copyWith(count: decoration.count + 1));
        found = true;
      } else {
        updatedDecorations.add(decoration); // Add the unmodified decoration to the new list
      }
    }

    if (!found) {
      updatedDecorations.add(RequestOrderIndentDecoration(type: type, count: 1));
    }

    state = state.copyWith(cake: state.cake.copyWith(decorations: updatedDecorations));

    debugPrint("Cake sheet : $state");
  }

  List<String> getDecorations() {
    List<String> decorations = [];
    for (RequestOrderIndentDecoration decoration in state.cake.decorations) {
      if (!decorations.contains(decoration.type)) {
        switch (decoration.type) {
          case "RS1":
            decorations.add("장미1");
          case "RS2":
            decorations.add("장미2");
          case "RS3":
            decorations.add("장미3");
            break;
          case "CM1":
            decorations.add("백일홍");
            break;
          case "HH1":
            decorations.add("접시꽃");
            break;
          case "DS1":
            decorations.add("데이지");
            break;
          case "CB1":
            decorations.add("벚꽃");
            break;
          case "HY1":
            decorations.add("수국1");
          case "HY2":
            decorations.add("수국2");
            break;
        }
      }
    }
    return decorations;
  }

  String getPrice() {
    int price = 0;

    // 데코레이션 가격
    for (RequestOrderIndentDecoration decoration in state.cake.decorations) {
      switch (decoration.type) {
        case "RS1":
          price += 2000 * decoration.count;
          break;
        case "RS2":
          price += 2000 * decoration.count;
          break;
        case "RS3":
          price += 2000 * decoration.count;
          break;
        case "CM1":
          price += 1000 * decoration.count;
          break;
        case "HH1":
          price += 2000 * decoration.count;
          break;
        case "DS1":
          price += 1000 * decoration.count;
          break;
        case "CB1":
          price += 1000 * decoration.count;
          break;
        case "HY1":
          price += 5000 * decoration.count;
          break;
        case "HY2":
          price += 5000 * decoration.count;
          break;
      }
    }

    // 케이크 사이즈 가격
    if (state.cake.size == CakeSizeType.One.transText) {
      price += 40000;
    } else if (state.cake.size == CakeSizeType.Two.transText) {
      price += 50000;
    } else if (state.cake.size == CakeSizeType.Three.transText) {
      price += 60000;
    }
    final formatter = NumberFormat('#,###');
    return formatter.format(price);
  }

  int getTotalPrice() {
    String price = getPrice().replaceAll(RegExp('[^0-9]'), '');
    return int.parse(price) + 4900; // + 배송비
  }

  void updateCakeSheet(String sheetKey) {
    state = state.copyWith(cake: state.cake.copyWith(sheet: sheetKey));
    debugPrint("Cake sheet : $state");
  }

  void init() {
    state = RequestOrderIndentModel(
      message: RequestOrderIndentMessage(reason: "", request: "", memo: ""),
      receiver: RequestOrderIndentReceiver(name: "", phone: "", address: ""),
      price: RequestOrderIndentPrice(total: 0),
      cake: RequestOrderIndentCake(
        size: CakeSizeType.One.transText,
        sheet: "",
        taste: FlavorType.Vanilla.transText,
        jam: FilingType.Blueberry.transText,
        imagePath: "",
        decorations: [],
      ),
      payment: "CARD",
    );
  }
}
