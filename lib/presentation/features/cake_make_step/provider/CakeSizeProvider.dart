import 'package:hooks_riverpod/hooks_riverpod.dart';

enum CakeSizeType { One, Two, Three }

// flavorType to string
extension CakeSizeTypeExtension on CakeSizeType {
  String get sizeType {
    switch (this) {
      case CakeSizeType.One:
        return "1호";
      case CakeSizeType.Two:
        return "2호";
      case CakeSizeType.Three:
        return "3호";
    }
  }
  String get transText {
    switch (this) {
      case CakeSizeType.One:
        return "NO1";
      case CakeSizeType.Two:
        return "NO2";
      case CakeSizeType.Three:
        return "NO3";
    }
  }
}

final cakeSizeProvider = StateNotifierProvider<CakeSizeNotifier, CakeSizeType>((_) {
  return CakeSizeNotifier();
});

class CakeSizeNotifier extends StateNotifier<CakeSizeType> {
  CakeSizeNotifier() : super(CakeSizeType.One);

  void changeSize(CakeSizeType sizeType) => state = sizeType;

  void init() => state = CakeSizeType.One;
}
