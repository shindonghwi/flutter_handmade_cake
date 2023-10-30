import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FlavorType { Vanilla, Choco, Carrot, RedVelvet }

// flavorType to string
extension FlavorTypeExtension on FlavorType {
  String get flavorType {
    switch (this) {
      case FlavorType.Vanilla:
        return "바닐라";
      case FlavorType.Choco:
        return "초코";
      case FlavorType.Carrot:
        return "당근";
      case FlavorType.RedVelvet:
        return "레드벨벳";
    }
  }
}



final cakeFlavorProvider = StateNotifierProvider<CakeFlavorNotifier, FlavorType>((_) {
  return CakeFlavorNotifier();
});

class CakeFlavorNotifier extends StateNotifier<FlavorType> {
  CakeFlavorNotifier() : super(FlavorType.Vanilla);

  void changeFlavor(FlavorType flavor) => state = flavor;

  void init() => state = FlavorType.Vanilla;
}
