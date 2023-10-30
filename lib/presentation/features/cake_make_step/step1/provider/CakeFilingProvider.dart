import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FilingType { Blueberry, Strawberry, Raspberry, Apricot }

// flavorType to string
extension FilingTypeExtension on FilingType {
  String get filingType {
    switch (this) {
      case FilingType.Blueberry:
        return "블루베리";
      case FilingType.Strawberry:
        return "딸기";
      case FilingType.Raspberry:
        return "라즈베리";
      case FilingType.Apricot:
        return "살구";
    }
  }
}



final cakeFilingProvider = StateNotifierProvider<CakeFilingNotifier, FilingType>((_) {
  return CakeFilingNotifier();
});

class CakeFilingNotifier extends StateNotifier<FilingType> {
  CakeFilingNotifier() : super(FilingType.Blueberry);

  void changeFiling(FilingType flavor) => state = flavor;

  void init() => state = FilingType.Blueberry;
}
