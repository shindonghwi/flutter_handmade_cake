import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:handmade_cake/navigation/PageMoveUtil.dart';
import 'package:handmade_cake/navigation/Route.dart';
import 'package:handmade_cake/presentation/components/utils/BaseScaffold.dart';
import 'package:handmade_cake/presentation/components/utils/Clickable.dart';
import 'package:handmade_cake/presentation/ui/colors.dart';
import 'package:handmade_cake/presentation/utils/Common.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 600),
    );

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 300), () async {
        await animationController.forward();
        Future.delayed(const Duration(milliseconds: 1000), () {
          Navigator.pushReplacement(
            context,
            nextFadeInOutScreen(RoutingScreen.SignIn.route),
          );
        });
      });
      return;
    }, const []);

    return BaseScaffold(
      backgroundColor: getColorScheme(context).colorPrimary900,
      body: Center(
        child: FadeTransition(
          opacity: animationController,
          child: SvgPicture.asset(
            "assets/imgs/splash_logo.svg",
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}
