import 'package:flutter/material.dart';
import 'package:handmade_cake/presentation/utils/dto/Triple.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/dto/Pair.dart';

final canvasWidgetsProvider = StateNotifierProvider<CanvasWidgetsNotifier, List<Triple<Widget, String?, String?>>>(
  (_) => CanvasWidgetsNotifier(),
);

class CanvasWidgetsNotifier extends StateNotifier<List<Triple<Widget, String?, String?>>> {
  CanvasWidgetsNotifier() : super([]);

  void setBackgroundWidget(Widget widget) {
    debugPrint("widget count: ${state.length}");

    if (state.isNotEmpty) {
      state.removeAt(0);
    }

    state.insert(0, Triple(widget, null, null));
    state = List.from(state);
    debugPrint("widget count: ${state.length}");
  }

  void addWidget(Widget widget, String widgetKey, String decorationType) {
    debugPrint("widget count: ${state.length}");
    state.add(Triple(widget, widgetKey, decorationType));
    state = List.from(state);
    debugPrint("widget count: ${state.length}");
  }

  void removeWidget(String widgetKey) {
    debugPrint("widget count: ${state.length}");
    state.removeWhere((element) => element.second == widgetKey);
    state = List.from(state);
    debugPrint("widget count: ${state.length}");
  }

  int getSize() => state.length;

  void clearAll() {
    state = [];
    debugPrint("All decorations cleared. Remaining widget count: ${state.length}");
  }

}
