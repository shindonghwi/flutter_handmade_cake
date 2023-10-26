import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final canvasWidgetsProvider = StateNotifierProvider<CanvasWidgetsNotifier, List<Widget>>(
  (_) => CanvasWidgetsNotifier(),
);

class CanvasWidgetsNotifier extends StateNotifier<List<Widget>> {
  CanvasWidgetsNotifier() : super([]);

  void setBackgroundWidget(Widget widget) {
    debugPrint("widget count: ${state.length}");

    if (state.isNotEmpty) {
      state.removeAt(0);
    }

    state.insert(0, widget);
    state = List.from(state);
    debugPrint("widget count: ${state.length}");
  }

  void addWidget(Widget widget) {
    debugPrint("widget count: ${state.length}");
    state.add(widget);
    state = List.from(state);
    debugPrint("widget count: ${state.length}");
  }

  int getSize() => state.length;

  void clearAll() {
    state = [];
    debugPrint("All decorations cleared. Remaining widget count: ${state.length}");
  }

}
