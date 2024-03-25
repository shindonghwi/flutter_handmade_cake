import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:handmade_cake/presentation/components/canvas/ResizableImage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BaseScaffold extends HookConsumerWidget {
  final Widget body;
  final Widget? bottomNavigationBar;
  final bool extendBody;
  final Color? backgroundColor;
  final PreferredSizeWidget? appBar;
  final bool isCanvasMode;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const BaseScaffold({super.key,
    required this.body,
    this.extendBody = false,
    this.appBar,
    this.backgroundColor,
    this.floatingActionButton,
    this.isCanvasMode = false,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {



    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (isCanvasMode){
              final focusedWidgetKeyRead = ref.read(focusedWidgetProvider.notifier);
              focusedWidgetKeyRead.state = null;
            }
          },
          behavior: HitTestBehavior.translucent,
          child: body,
        ),
      ),
      extendBody: extendBody,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
