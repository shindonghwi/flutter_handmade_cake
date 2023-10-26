import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';

import '../../utils/Common.dart';

class LoadingView extends HookWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getMediaQuery(context).size.width,
      height: getMediaQuery(context).size.height,
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          getColorScheme(context).colorPrimary500,
        ),
      )),
    );
  }
}
